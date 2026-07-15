const axios = require('axios');
const cheerio = require('cheerio');
const fs = require('fs');
const path = require('path');
const { v4: uuidv4 } = require('uuid');

const categories = {
    "Traditional": "a0000000-0000-0000-0000-000000000001",
    "Animals":     "a0000000-0000-0000-0000-000000000002",
    "Birds":       "a0000000-0000-0000-0000-000000000003",
    "Boxes":       "a0000000-0000-0000-0000-000000000004",
    "Flowers":     "a0000000-0000-0000-0000-000000000005",
    "Stars":       "a0000000-0000-0000-0000-000000000006",
    "Toys":        "a0000000-0000-0000-0000-000000000007"
};

const outputData = {
    Categories: Object.entries(categories).map(([name, id]) => ({
        Id: id,
        Name: name,
        Slug: name.toLowerCase(),
        Description: `${name} origami models.`,
        Icon: `assets/icons/${name.toLowerCase()}.svg`
    })),
    OrigamiModels: [],
    OrigamiSteps: []
};

async function scrapeIndex() {
    const response = await axios.get('https://origami.me/diagrams/');
    const $ = cheerio.load(response.data);
    const links = [];
    $('a').each((i, el) => {
        const href = $(el).attr('href');
        if (href && href.startsWith('https://origami.me/') && !href.includes('/diagrams/') && !href.includes('/about/') && !href.includes('/contact/')) {
            const img = $(el).find('img');
            if (img.length > 0 && !links.includes(href)) {
                links.push(href);
            }
        }
    });
    console.log(`Found ${links.length} potential links`);
    return links;
}

async function scrapeModel(url) {
    try {
        const response = await axios.get(url);
        const $ = cheerio.load(response.data);

        // Clean up title
        let title = $('h1').text().trim();
        title = title
            .replace(/^How To Make An /i, '')
            .replace(/^How To Make A /i, '')
            .replace(/^How To Fold An /i, '')
            .replace(/^How To Fold A /i, '')
            .replace(/^Easy /i, '')
            .replace(/^Very Easy /i, '')
            .replace(/ Origami$/i, '')
            .replace(/ Instructions$/i, '')
            .trim();

        if (!title) return null;

        // Get difficulty from page text
        const textContent = $('body').text().toLowerCase();
        let difficulty = 1;
        if (textContent.includes('advanced')) difficulty = 3;
        else if (textContent.includes('intermediate')) difficulty = 2;
        if (textContent.includes('expert') || textContent.includes('complex')) difficulty = 4;

        // Detect category from title
        let categoryName = 'Traditional';
        const t = title.toLowerCase();
        if (t.match(/\b(crane|owl|pigeon|swan|duck|flapping bird|parrot|peacock|eagle|dove)\b/)) categoryName = 'Birds';
        else if (t.match(/\b(dog|cat|frog|fox|rabbit|pig|mouse|turtle|elephant|squirrel|dragon|bat|dinosaur|horse|bear)\b/)) categoryName = 'Animals';
        else if (t.match(/\b(box|container|dish|tray|basket)\b/)) categoryName = 'Boxes';
        else if (t.match(/\b(rose|lily|lotus|tulip|flower|floral)\b/)) categoryName = 'Flowers';
        else if (t.match(/\b(star|lucky star)\b/)) categoryName = 'Stars';
        else if (t.match(/\b(boat|plane|ninja|shuriken|toy|spinner|fortune teller|fan|heart|butterfly|envelope|bookmark|jumping|water bomb)\b/)) categoryName = 'Toys';

        const categoryId = categories[categoryName];
        const modelId = uuidv4();

        // Thumbnail: og:image meta tag (the most reliable)
        let coverImage = $('meta[property="og:image"]').attr('content') || '';

        // *** Extract steps using .is-style-group-step selector ***
        const steps = [];
        $('.is-style-group-step').each((i, el) => {
            const stepEl = $(el);

            // Step number from h3
            const h3Text = stepEl.find('h3').text().trim();
            const numMatch = h3Text.match(/\d+/);
            const stepNum = numMatch ? parseInt(numMatch[0]) : (i + 1);

            // Step image: grab href from first .wp-block-image a (the actual photo, not diagram)
            let imageUrl = '';
            const imageLinks = stepEl.find('.wp-block-image a');
            if (imageLinks.length > 0) {
                // Prefer non-diagram image (photo over diagram)
                imageLinks.each((j, imgLink) => {
                    const href = $(imgLink).attr('href') || '';
                    if (!imageUrl && href && !href.includes('diagram')) {
                        imageUrl = href;
                    }
                });
                // Fall back to any image
                if (!imageUrl) {
                    imageUrl = $(imageLinks.first()).attr('href') || '';
                }
            }

            // Step description: first <p> inside step container (not the tip)
            let description = '';
            const paragraphs = stepEl.find('p');
            paragraphs.each((j, p) => {
                const text = $(p).text().trim();
                if (text && !description && !text.startsWith('🕊️') && !text.startsWith('💡')) {
                    description = text;
                }
            });

            if (!description) description = `Step ${stepNum}: Follow the diagram carefully.`;

            if (imageUrl) {
                // Fix relative URLs
                if (imageUrl.startsWith('//')) imageUrl = 'https:' + imageUrl;
                else if (imageUrl.startsWith('/')) imageUrl = 'https://origami.me' + imageUrl;

                steps.push({
                    Id: uuidv4(),
                    OrigamiModelId: modelId,
                    StepNumber: stepNum,
                    Title: `Step ${stepNum}`,
                    Description: description,
                    ImageUrl: imageUrl
                });
            }
        });

        // Fallback: if .is-style-group-step not found, try by alt/src matching
        if (steps.length === 0) {
            $('img').each((i, el) => {
                let src = $(el).attr('data-lazy-src') || $(el).attr('src') || $(el).attr('data-src') || '';
                const alt = ($(el).attr('alt') || '').toLowerCase();
                if (!src || src.startsWith('data:') || src.includes('logo')) return;
                if (src.startsWith('//')) src = 'https:' + src;
                else if (src.startsWith('/')) src = 'https://origami.me' + src;

                const stepMatch = alt.match(/step\s*(\d+)/i) || src.match(/step-?(\d+)/i);
                if (stepMatch) {
                    const stepNum = parseInt(stepMatch[1]);
                    if (!steps.find(s => s.StepNumber === stepNum)) {
                        steps.push({
                            Id: uuidv4(),
                            OrigamiModelId: modelId,
                            StepNumber: stepNum,
                            Title: `Step ${stepNum}`,
                            Description: `Carefully fold following the diagram for step ${stepNum}.`,
                            ImageUrl: src
                        });
                    }
                }
            });
        }

        if (steps.length === 0) return null;
        steps.sort((a, b) => a.StepNumber - b.StepNumber);

        outputData.OrigamiModels.push({
            Id: modelId,
            CategoryId: categoryId,
            Name: title,
            Slug: title.toLowerCase().replace(/\s+/g, '-').replace(/[^a-z0-9-]/g, ''),
            Description: `Learn how to fold a beautiful origami ${title}. Follow our step-by-step instructions.`,
            Difficulty: difficulty,
            ThumbnailUrl: coverImage,
            CoverImageUrl: coverImage,
            EstimatedMinutes: Math.max(5, Math.ceil(steps.length * 0.5)),
            Materials: 'Square Paper'
        });

        outputData.OrigamiSteps.push(...steps);

        console.log(`✓ ${title}: ${steps.length} steps, difficulty=${difficulty}, category=${categoryName}`);
        return true;
    } catch (e) {
        console.error(`✗ Failed ${url}: ${e.message}`);
        return false;
    }
}

async function run() {
    let links = await scrapeIndex();

    // Reliable known URLs first
    const reliable = [
        'https://origami.me/crane/',
        'https://origami.me/jumping-frog/',
        'https://origami.me/boat/',
        'https://origami.me/ninja-star/',
        'https://origami.me/butterfly/',
        'https://origami.me/water-bomb/',
        'https://origami.me/fortune-teller/',
        'https://origami.me/flapping-bird/',
        'https://origami.me/heart/',
        'https://origami.me/fox/',
        'https://origami.me/swan/',
        'https://origami.me/fox-box/',
        'https://origami.me/turtle/',
        'https://origami.me/rabbit/',
        'https://origami.me/dragon/',
        'https://origami.me/bat/',
        'https://origami.me/lily/',
        'https://origami.me/lotus/',
        'https://origami.me/rose/',
        'https://origami.me/tulip/',
        'https://origami.me/lucky-star/',
        'https://origami.me/envelope/',
        'https://origami.me/corner-bookmark/',
        'https://origami.me/squirrel/',
        'https://origami.me/owl/',
    ];

    links = [...new Set([...reliable, ...links])];

    const seenSlugs = new Set();
    let count = 0;
    for (const link of links) {
        if (count >= 25) break;
        const result = await scrapeModel(link);
        if (result) {
            count++;
            // Check for dup slug in outputData and remove if found
            const slugs = outputData.OrigamiModels.map(m => m.Slug);
            const seen = new Set();
            outputData.OrigamiModels.forEach(m => {
                if (seen.has(m.Slug)) {
                    // Remove steps for this model
                    outputData.OrigamiSteps = outputData.OrigamiSteps.filter(s => s.OrigamiModelId !== m.Id);
                }
                seen.add(m.Slug);
            });
            // Remove dup models
            const uniqueIds = new Set();
            outputData.OrigamiModels = outputData.OrigamiModels.filter(m => {
                if (uniqueIds.has(m.Slug)) return false;
                uniqueIds.add(m.Slug);
                return true;
            });
        }
        await new Promise(r => setTimeout(r, 600));
    }

    const outPath = path.join(__dirname, '../src/OrigamiMaster.API/Data/origami_data.json');
    fs.mkdirSync(path.dirname(outPath), { recursive: true });
    fs.writeFileSync(outPath, JSON.stringify(outputData, null, 2));

    console.log(`\nDone! Saved ${outputData.OrigamiModels.length} models and ${outputData.OrigamiSteps.length} steps to ${outPath}`);
}

run();
