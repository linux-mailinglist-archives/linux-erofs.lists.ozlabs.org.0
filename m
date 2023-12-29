Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CAEF81FD06
	for <lists+linux-erofs@lfdr.de>; Fri, 29 Dec 2023 05:39:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1703824742;
	bh=0Pc7Al4rtacPHt5x42YlE5/SwdTMREKFDX11H2Lmkuo=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=mBYMAyGv1ZvrVYKqFEbWwHFSHevITpLumqE8/vC0I+PUTxZdt70lLxFn3uJjzkJph
	 dFI87ry08kdNi1Z0P/CTd5fQG75PM7Xk4Y907iJk4PDZZKxRkAM5z0P7mmWFBwX5EK
	 8g3zzxlHmPnknFKynG6mCP0B+CDlUhApOEMsRS99D38O3ZCjcAQwwIL1qNQu+woEkN
	 9htLJOcp6HlLbnKMHTSiM7EHVq/GBMpyYNTe/b8y/oYzbpaAjEwrTclvw7+effL++/
	 NHpvslC1XLW3smdAxW5IWoPJssldb+n37vPafNXbkKt1VAd2+rF0eBfz8YISx9ir/H
	 Prue4fzKA6lCA==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4T1XhQ2fqGz3bTN
	for <lists+linux-erofs@lfdr.de>; Fri, 29 Dec 2023 15:39:02 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=vivo.com header.i=@vivo.com header.a=rsa-sha256 header.s=selector2 header.b=OaTjVJLi;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=vivo.com (client-ip=2a01:111:f400:feab::70b; helo=apc01-sg2-obe.outbound.protection.outlook.com; envelope-from=guochunhai@vivo.com; receiver=lists.ozlabs.org)
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2070b.outbound.protection.outlook.com [IPv6:2a01:111:f400:feab::70b])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4T1XhD6HFpz30Q3
	for <linux-erofs@lists.ozlabs.org>; Fri, 29 Dec 2023 15:38:50 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WpMhPTNPLdW58wDgKfSky6vJ0RlNIsNhndkXfY1O6qhwghtiv1wnYVuFLrmyAkVuBMYX8ooMoTJOvYDJ7AnOf1Mg0vvLXYq5GmgGYYPO4EUvjZLG9NIDqTd8kOT9mdVVGjl6qGRuVymAycPu6gMYmbJkiSXz7pecwtNXdLdJzSgWphhjsjM4rWeHXtUup5sYj+QdnEWH6HTfe1To9EcWTHYKq4Nbb7blN8cz3ustT7XDSy/i9VbdiQdbVQigjdopY0Rjq4TbuPrZMdzmer2xF3dgxyW61z5JKeOaR+mVgJdZUorkPcHEArjvl7fZA8IPyBnwBsywqwZsQvPNhvJVHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Pc7Al4rtacPHt5x42YlE5/SwdTMREKFDX11H2Lmkuo=;
 b=Qp/scsvurDOUcbCiKsdsW208EITBHfDVsdV9V7QYQCmgZ0+OEU1SAFJoXWtnuw6kJXm64VVKbzGChaHJo3a7EtzHqGTe6fWKQUmrSoL233jh7RQakngKfxBK1P4T7e995R643gHV9Q424RYtKU9OR6almxjXSbUfcBSfjXVjLkkN2yenOcpW3/k/mk26/ygP0lsbK89IDokoXJ+5jGN0eAj7xFsjbBblThXkX3kdOwnoMepxnQMxOBJFT6Kv26J3HNUCPC5E/hTdZtO3XIrCUMBPlJmYUgs2OS2SvKv2i0ks6PwaqcgFNqpKO3wMT5qkkmE61Cyou1lcXgMFJInYDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TY2PR06MB3342.apcprd06.prod.outlook.com (2603:1096:404:fb::23)
 by TYZPR06MB7375.apcprd06.prod.outlook.com (2603:1096:405:a2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.21; Fri, 29 Dec
 2023 04:38:27 +0000
Received: from TY2PR06MB3342.apcprd06.prod.outlook.com
 ([fe80::6d6f:ced1:956e:35ac]) by TY2PR06MB3342.apcprd06.prod.outlook.com
 ([fe80::6d6f:ced1:956e:35ac%3]) with mapi id 15.20.7113.027; Fri, 29 Dec 2023
 04:38:27 +0000
To: xiang@kernel.org
Subject: Re: [PATCH] erofs: add a global page pool for lz4 decompression
Date: Thu, 28 Dec 2023 21:48:33 -0700
Message-Id: <20231229044833.2026565-1-guochunhai@vivo.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <96632ab5-3748-4512-aeae-2e931ff14674@linux.alibaba.com>
References: <96632ab5-3748-4512-aeae-2e931ff14674@linux.alibaba.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0017.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::10) To TY2PR06MB3342.apcprd06.prod.outlook.com
 (2603:1096:404:fb::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY2PR06MB3342:EE_|TYZPR06MB7375:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ef91c6b-d85d-4a15-4546-08dc08280024
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	uF8MB/HZtuUb55WroeoAXzbpI8WtWqRqc1QOwv6pqF1V2dy8kTmjhWkRHd7KGodubJ4igHKDOWPhDWHBfgadghwFJjkBzg2+JX0e9p7ttuXn6H2HaNXxIrx72d8nSLRLWV6Ts1YucQrrWZ5NcYb+wRxsXFIRydLzElDmoR7SKhWzTJO0aMRV0Lbhli4MvbVOcHkj2djrtWPS9O9tj15zNbSPDC8tXoK0B/MEvA/MIf6tSYAhwFL/d2KWU/eqZTjBxEF7Cdi/8nWpERne4Ay7kDJoCB6/jovATn1bUIYRd6cQ1q7GO95nVSPX3iuDwWymOPO2+K3wIsCcqwT17aUb6a68x94XUI58LHk8K+bHFNx8jvTZ9sEKx66tvpXOnaRZ4IEBc6yL7qL0HxgjyN0GI67fcHyrYlsftnTwA3CFHK4ezENPCmMx5H9i9zM0IKp9oWOzhRyTRFuMKh7F/SohlS6cEzrlLBR9WrH2ISqp0gG5uhyrF0WDGMg/A4Vv8xQrvpWddXZvGnKVgW5jcwo7J1wSia61WaZA2h5KGSn4HuisxRNHtFZHixuBJkSLHQo+fCxUaw3R2BZ0jw9hTGj5HHjx1JHI+YpPCwHCMnelodQDiZT0HYK0Lr/xB0Rf5XVb
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR06MB3342.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(39850400004)(346002)(366004)(136003)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(4326008)(2906002)(5660300002)(8676002)(8936002)(316002)(6916009)(66476007)(66556008)(66946007)(6486002)(41300700001)(478600001)(6666004)(52116002)(6506007)(6512007)(53546011)(2616005)(26005)(1076003)(36756003)(83380400001)(38350700005)(38100700002)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?us-ascii?Q?CKRxd8oJQyfNJ6xDijmjN3cQQJ5CpRnvCDB4JskIrdaZP4Dt625/s1VjvPfG?=
 =?us-ascii?Q?aQ1DxYS3TqQH1yjVV4gH65r1+LxUWMs7Aer/6j8U8ws64+kWfb1lcU77cDHd?=
 =?us-ascii?Q?cTcF4ZldrgwlYPVIOwu4G3AnoBqXJ+NYgvwrPxsU7rAB+T+zWIk2+6HgcMkp?=
 =?us-ascii?Q?QYyxqI2b4h5QY0KnfCWStnb3DggwS5PRJb8VNp7CzJQRkUwCA8WDwOEyQ3hz?=
 =?us-ascii?Q?xODt9PjilzqfV0YK/bukMgaKtHGs5mpY3/nlTFjEEdIgoTZ68iahs0uSRwFj?=
 =?us-ascii?Q?LfuqfR26NosB46x2YowID87gfB3DyVNeEdGGQORfOcoEayKxBVqUbdFEuuHo?=
 =?us-ascii?Q?OPccWZuk987dGvwk6Yi19yAvF0y7ID6ekIhNMfulCBvFmrqtS2fIf7L0i03P?=
 =?us-ascii?Q?2zc+PHCPHZrlJqtPsJxnyz9WS8tr4opggMBrbn5KkZv2Bpar3zi5A/s8ncXE?=
 =?us-ascii?Q?ohYmvV7W9s6HlgwpTHIt/kr3YOlnlrYdGqBwlhCyCL7y5cpmMKW3EvGRD6gS?=
 =?us-ascii?Q?0HOdU6GJJjamcIyu4q8cg9cvQCdhgoum6PnWie9S8RNPBjdq6gEetvusoxzu?=
 =?us-ascii?Q?AN1N8cIdVTHyW+YiUKS1MXWbPBG416fp+dvt5yfflS5YRbQRfvBd6b7NcLeA?=
 =?us-ascii?Q?bKgvP9OYzG13mevQMaCn4wxodyvvRsHjN0o/MeEElWg1Xlib7kIxO8hoG7Ap?=
 =?us-ascii?Q?YHoj+xzt2LXhBU8yu1qdoNYYKjKgMPGaZa9rDLYrH2nNNoj/Vmk2r3cz4o5A?=
 =?us-ascii?Q?SSyiNiByGEiy1oqFTRd9QkUO3Ly+vlKRKZC2qe9SmNl02gQ+PCvtoYvuRb6i?=
 =?us-ascii?Q?WtoDrMrJ/TihA9m8dGuBZvBROnHgv1LSm+UBV23HtkXhuFub2SvlR/3ayd/m?=
 =?us-ascii?Q?F6FCU+kjrfdbu6fcU7PFsCejNpSWjGp0bKiffExg6F5IbqMbGjkbK0NFxVQY?=
 =?us-ascii?Q?K8fzUFH0Ry7CAlHp0wJvmd1x8HmNV4MvFHoPALY+BNpDXL+t3ql9CcsJmCvm?=
 =?us-ascii?Q?KSoOOwoO4wRwEwSNxmzgm5FDwDZg+budtqd94CSUwiSo27Uk+XSq6qyRcQhk?=
 =?us-ascii?Q?7eiHn8sjOZGyam6OFcfW/vv/TteHZKVny0MMvGbqVQSqfbBnBNh0wBH+8IaK?=
 =?us-ascii?Q?6Y/sDlrZK3f7o25MhwV5YRXztqDNSAC8dN3tAgjMjbgEddX+K/PFOdgVCGC5?=
 =?us-ascii?Q?OmEBeicpZTGoxr33gLbTfhC9n8488W0CVTnf40slxPPSMKKxJhVN0StmS19t?=
 =?us-ascii?Q?YZBnkE1qV9e0io4BD4e8PzzlGHnRldEQ3E1ddyNRZ2Lqe4z7FmbDfxxI/z3u?=
 =?us-ascii?Q?Kja6Nv5P4sPPY6xMHL6yf1/G+8ZfCZ/TkPMG9EABsZ5n7SuNCl2l3+kdyWZ2?=
 =?us-ascii?Q?cpMbDP3ec21rg0+CKOLL0axfCaCqX85RV6rt8W2dDb2JQBFf64koEihcjOhZ?=
 =?us-ascii?Q?r2ZQDTLV2tgvOaFVb86wJ8x8UWudxgtMYVdGO3fhT5Bskgc8jmA+Y8acqCPU?=
 =?us-ascii?Q?1HVkpPC9EEvar693cxgnPvHAWDmyrr3vVC9wXGkwlYGQgyuI4osJ2U+rHYEJ?=
 =?us-ascii?Q?fLTeUAn9a8jyKhgmEK8drMXFu+wEv/omtjXX6RfE?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ef91c6b-d85d-4a15-4546-08dc08280024
X-MS-Exchange-CrossTenant-AuthSource: TY2PR06MB3342.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Dec 2023 04:38:27.5392
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O2B2+/RDnMiRsHcg+gH+Vdz+3IA7DAQGO/EnEfJStWqdeZ2P5yRZ8GgtQHYcmnMlKkDpzDPDQNitR/20MIRiJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB7375
X-BeenThere: linux-erofs@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Development of Linux EROFS file system <linux-erofs.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linux-erofs/>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Help: <mailto:linux-erofs-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=subscribe>
From: Chunhai Guo via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Chunhai Guo <guochunhai@vivo.com>
Cc: linux-erofs@lists.ozlabs.org, huyue2@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

> Hi Chunhai,
> 
> On 2023/12/28 21:00, Chunhai Guo wrote:
> > Using a global page pool for LZ4 decompression significantly reduces 
> > the time spent on page allocation in low memory scenarios.
> >
> > The table below shows the reduction in time spent on page allocation 
> > for
> > LZ4 decompression when using a global page pool.
> > The results were obtained from multi-app launch benchmarks on ARM64 
> > Android devices running the 5.15 kernel.
> > +--------------+---------------+--------------+---------+
> > |              | w/o page pool | w/ page pool |  diff   |
> > +--------------+---------------+--------------+---------+
> > | Average (ms) |     3434      |      21      | -99.38% |
> > +--------------+---------------+--------------+---------+
> >
> > Based on the benchmark logs, it appears that 256 pages are sufficient 
> > for most cases, but this can be adjusted as needed. Additionally, 
> > turning on CONFIG_EROFS_FS_DEBUG will simplify the tuning process.
> 
> Thanks for the patch. I have some questions:
>   - what pcluster sizes are you using? 4k or more?
We currently use a 4k pcluster size. 

>   - what the detailed configuration are you using for the multi-app
>     launch workload? Such as CPU / Memory / the number of apps.

We ran the benchmark on Android devices with the following configuration.
In the benchmark, we launched 16 frequently-used apps, and the camera app
was the last one in each round. The results in the table above were
obtained from the launching process of the camera app.
	CPU: 8 cores
	Memory: 8GB

> >
> > This patch currently only supports the LZ4 decompressor, other 
> > decompressors will be supported in the next step.
> >
> > Signed-off-by: Chunhai Guo <guochunhai@vivo.com>
> > ---
> >   fs/erofs/compress.h     |   1 +
> >   fs/erofs/decompressor.c |  42 ++++++++++++--
> >   fs/erofs/internal.h     |   5 ++
> >   fs/erofs/super.c        |   1 +
> >   fs/erofs/utils.c        | 121 ++++++++++++++++++++++++++++++++++++++++
> >   5 files changed, 165 insertions(+), 5 deletions(-)
> >
> > diff --git a/fs/erofs/compress.h b/fs/erofs/compress.h index 
> > 279933e007d2..67202b97d47b 100644
> > --- a/fs/erofs/compress.h
> > +++ b/fs/erofs/compress.h
> > @@ -31,6 +31,7 @@ struct z_erofs_decompressor {
> >   /* some special page->private (unsigned long, see below) */
> >   #define Z_EROFS_SHORTLIVED_PAGE             (-1UL << 2)
> >   #define Z_EROFS_PREALLOCATED_PAGE   (-2UL << 2)
> > +#define Z_EROFS_POOL_PAGE            (-3UL << 2)
> >
> >   /*
> >    * For all pages in a pcluster, page->private should be one of diff 
> > --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c index 
> > d08a6ee23ac5..41b34f01416f 100644
> > --- a/fs/erofs/decompressor.c
> > +++ b/fs/erofs/decompressor.c
> > @@ -54,6 +54,7 @@ static int z_erofs_load_lz4_config(struct super_block *sb,
> >       sbi->lz4.max_distance_pages = distance ?
> >                                       DIV_ROUND_UP(distance, PAGE_SIZE) + 1 :
> >                                       LZ4_MAX_DISTANCE_PAGES;
> > +     erofs_global_page_pool_init();
> >       return erofs_pcpubuf_growsize(sbi->lz4.max_pclusterblks);
> >   }
> >
> > @@ -111,15 +112,42 @@ static int z_erofs_lz4_prepare_dstpages(struct z_erofs_lz4_decompress_ctx *ctx,
> >                       victim = availables[--top];
> >                       get_page(victim);
> >               } else {
> > -                     victim = erofs_allocpage(pagepool,
> > +                     victim = erofs_allocpage_for_decmpr(pagepool,
> >                                                GFP_KERNEL | 
> > __GFP_NOFAIL);
> 
> For each read request, the extreme case here will be 15 pages for 64k LZ4 sliding window (60k = 64k-4k). You could reduce
> LZ4 sliding window to save more pages with slight compression ratio loss.

OK, we will do the test on this. However, based on the data we have, 97% of
the compressed pages that have been read can be decompressed to less than 4
pages. Therefore, we may not put too much hope on this.

> 
> Or, here __GFP_NOFAIL is actually unnecessary since we could bail out this if allocation failed for all readahead requests
> and only address __read requests__.   I have some plan to do
> this but it's too close to the next merge window.  So I was once to work this out for Linux 6.9.

This sounds great. It is more likely another optimization related to this
case.

> 
> Anyway, I'm not saying mempool is not a good idea, but I tend to reserve memory as less as possible if there are some other way to mitigate the same workload since reserving memory is not free (which means 1 MiB memory will be only used for this.) Even we will do a mempool, I wonder if we could unify pcpubuf and mempool together to make a better pool.

I totally agree with your opinion. We use 256 pages for the worst-case
scenario, and 1 MiB is acceptable in 8GB devices. However, for 95% of
scenarios, 64 pages are sufficient and more acceptable for other devices.
And you are right, I will create a patch to unify the pcpubuf and mempool
in the next step.

> 
> IMHO, maybe we could do some analysis on your workload first and think how to do this next.

Yes, we can do more work on this and figure out what can be optimized.
Thanks

> 
> Thanks,
> Gao Xiang
