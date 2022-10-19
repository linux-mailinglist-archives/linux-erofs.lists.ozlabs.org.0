Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AEC360383C
	for <lists+linux-erofs@lfdr.de>; Wed, 19 Oct 2022 04:52:24 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MsZyY5k9tz3bnH
	for <lists+linux-erofs@lfdr.de>; Wed, 19 Oct 2022 13:52:21 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=m5tuEAu3;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.55.52.43; helo=mga05.intel.com; envelope-from=ira.weiny@intel.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=m5tuEAu3;
	dkim-atps=neutral
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MsZyS16pFz2xjr
	for <linux-erofs@lists.ozlabs.org>; Wed, 19 Oct 2022 13:52:10 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666147936; x=1697683936;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=S0gMdeKvVj5/KEGXIK9nockkF8OKvS7+OCuLAOupFyI=;
  b=m5tuEAu31Xu9H78xexlh3LUcVfQa4Xs/ImEyxkZWNu6tlgltIwRUTK5w
   Oo3Ot/5BKbgSA23vho5Fp/E0QhH9vhiObYdkNQesa8U9ZRYQNRDsxm6OK
   sZqvpyK9pCugqoEJFM5w2yZfbVaYi2kS4gv01CDF2xzuCq9fXRGoqaLJM
   NqsMIKrsBtBN1s8riT3OdIaNcRwRKjL8/ABfvk25es9Od2ARfZfNCnP2L
   dbjZkgSC9RiuPcsr/zcd2vKetLf9lN2TpKwdRtH4AIpif9K+cxa4XBIL4
   We5LVZTXTTHS8e8fm2B63Tojly2cLRyifStAhbDJZY5Pc6QtFZtWHUhXZ
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="392591979"
X-IronPort-AV: E=Sophos;i="5.95,194,1661842800"; 
   d="scan'208";a="392591979"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2022 19:52:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="958102664"
X-IronPort-AV: E=Sophos;i="5.95,194,1661842800"; 
   d="scan'208";a="958102664"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga005.fm.intel.com with ESMTP; 18 Oct 2022 19:52:05 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 18 Oct 2022 19:52:05 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 18 Oct 2022 19:52:05 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 18 Oct 2022 19:52:05 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.102)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 18 Oct 2022 19:52:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PcvkmOH37k/GTVpc9p8oPWvWoP5cBigSko19kWWzjfhscjRYpq5TaHSWMZVsysTCTP5TxV3co1rw0O0JdYDablgD6KbEeVX000JNQV37bVxVyBtHOzL6oQljORbFqJ2Hgqohmhe0t/bgaUsYbfrw+aHm+ckcR4zIOMzzFxOPzomhaCA4VUNqmZLBavty0nCEBjzMnT3VA3dhAQLzpxaUKRl4nWedBvzDBkYkDF+AaCynyUu1qKNZqHdF5gM2TTQzdPvlkEWIqm/SR/23stj5F+C7QA8ALWhMKxFQOkuCip2ZcRPGzfKmO+b4O5bewgh3u55JXRFjVb4YV6F5ZjHWQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gjh8r10D1zIR93k3zt2MnLBq8r7hmvD0IiESeKBmQ0Y=;
 b=D76WhHvR04LSq3LbewcjCIehCAfXQgm4UgEn0xJNFvnhY8nsFphf1F3BmYbL0bYkQrBDPR7lgD4ErW5UciTLltlRZ4X/7qVnzPIDpg9Zz6xtNnXgjD5kWPwSv+tulInqOYYwxGXMrA3RKgLyOnsUp9qaT8TBoY2PBecoPt9XaLq7LkZQQCbHQpZL9o7maN0XX4H+w8pomy6qYmgAyRz5WftZGi7jYkTJIitZBfehAjS1G4V8WKg3w7LSZHTG4sYiR1Y+eRqTsRDsfA52eooVvdbwzA2cHvT2kwlZmQfpz9iJemoaiV4MD3fOX1brb08/paKS1D2MtSlbDsFdwxJ6Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by SA3PR11MB7535.namprd11.prod.outlook.com (2603:10b6:806:307::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.33; Wed, 19 Oct
 2022 02:52:01 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6f83:c165:aa0c:efae]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6f83:c165:aa0c:efae%8]) with mapi id 15.20.5723.033; Wed, 19 Oct 2022
 02:51:59 +0000
Date: Tue, 18 Oct 2022 19:51:55 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [PATCH v2] erofs: use kmap_local_page() only for erofs_bread()
Message-ID: <Y09mS6LrHCGmi+AJ@iweiny-desk3>
References: <20221018105313.4940-1-hsiangkao@linux.alibaba.com>
 <9108233.CDJkKcVGEf@mypc>
 <Y08asdeoz5yOAefN@B-P7TQMD6M-0146.lan>
 <2019477.yKVeVyVuyW@mypc>
 <Y084l0m88JGOqGRN@B-P7TQMD6M-0146.lan>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y084l0m88JGOqGRN@B-P7TQMD6M-0146.lan>
X-ClientProxiedBy: SJ0PR03CA0050.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::25) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|SA3PR11MB7535:EE_
X-MS-Office365-Filtering-Correlation-Id: 7194342d-355f-4fe1-b535-08dab17ce487
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +U+6/uOMBlgcQFu/KTwep58rVjrxUVo144OLknNG6kdCEm7Yc8h6BnBEjZtSFn7VTRjbbJrucztoFMT8LGeegUTVzpn1Jsq/v9w7inrAJAy+qEizGvuY73YoiHEMP8AzBBDIYX/YsmiQpZQUOyBmQRPTDRXQmtcVAVVDcMcKRWuplKzVeQa/mzpxJPhIaTGymBFBN+qwyPbEG+w9INWd/ZVrsEvfASbJRJxKJ3fckMGRjosUIMAEr1jKae6Am0F3zxc7aeg32Cxo88+ArNtmMa01UffpC77zyYZxkGmhTVDHFyT9SIwM5YJAHuonhFe24Jgb+lunJjD1s8q6xGcqUxikAlUIBMRo0+52Dh8GMesmxqEQP8rQEBSXyMGNVPBc/prqx4LpBTidq96uOr1qBksI5z68PH18+elcTBRvrRnr3TLf+a2YZtoH0ByCcfcQPumjzWoNx/KW95unJv+RS7U5MpaWpHScR03dT+q9r/YpypN9VdtBKdtJsZjB6NLUiO6qVtag4sinBHN5SdoBsW9X2JU9Q4lOkXSfG+Z4BEMMOak9hDk7ABAPTqHDsd6mYcr5S+LzSg2akF0tQWXwwppbhTG8V106053TggkbKL/buvGR7Xvdp60IDNSaYzsL+nBnLHMfqBtG+4g/wgl/ArXnn83xE9TPLmdj9Kv1xIhZzHRZdl+3ufjwSPc241bFF0EXhsoDr1bSR0RhfD0LBnsYMNoIrx25OtmTxWS80LjJRvxHzxXQd0ZZXFtruGbydkFkySdsZbZVGjUiwXiDQg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(376002)(396003)(366004)(346002)(39860400002)(136003)(451199015)(86362001)(2906002)(41300700001)(8936002)(44832011)(5660300002)(316002)(6916009)(6486002)(54906003)(8676002)(4326008)(478600001)(66946007)(66476007)(66556008)(6666004)(38100700002)(9686003)(6512007)(53546011)(26005)(83380400001)(6506007)(82960400001)(186003)(33716001)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TK1M06qFiP0rTrbT5psmujinOQjhl+/L6YHUCynJR+gmQbQWniAkdZiUNfCD?=
 =?us-ascii?Q?tnfx+hjgNwTjf+tFOm+skelYbYEytTcRB19bBF2udosXjkTujrSowJJQMeYY?=
 =?us-ascii?Q?D9bdeXNRKoIivX04Q0U6VouEJa42YNzyfh3Lb0DXzmS3BJ8HRRjEph6aPIE/?=
 =?us-ascii?Q?qDtkSyKIWKtfBCchnr9tInAIBOYiHaFEi0ZhkqPVJ8wBsI4VOLmldIJaaJ+Z?=
 =?us-ascii?Q?Oybvsj3kL7L6jsr1UlDvd5lhxPdrx4JAQqzvcMQ5PxTp2eMVZiM15g+5fWZs?=
 =?us-ascii?Q?Z5XGBosnxI6aDmeE0ZCwwcecLxhHTO8nOBaSG73b/Bn3bT89iIW+OMfAXcpP?=
 =?us-ascii?Q?1rXsHBr2Qk6rfDl06Reu90RE4RAG9yfoZQ5d7jO67aBQVGcCcuwnSGaONcbl?=
 =?us-ascii?Q?cNAK7LrClJrNbakz/TJWpcb3VMT3pyiuvnJeGpRl/49AUGKT4uv5ojzdFs9J?=
 =?us-ascii?Q?LIddDO6VX706zMm3uh3Zw/17NIpIlgqvACTkOHaUto6TBGqQ8DL3aQawkPYk?=
 =?us-ascii?Q?cdQk8r5GWQZenoOxHRCmXSospre94EOdSwrp2/PTYtC1XxQqcebB7SnZ6Dxn?=
 =?us-ascii?Q?3PipfDLDiPZOp34smnuI/1hpovE2Y9CCcQdlIOu9y3J9oq5+E0c/jFnIMvsi?=
 =?us-ascii?Q?LV1B7fQxe21NEz9GUTf/w/52MFw78Xt3CxkvQ2CcdQgRYGm8o+0uYsXKLGpN?=
 =?us-ascii?Q?a/esCzQeb4oY86u1QO+eX8Awy98BJFwyPLqfleIhfbvZZ6d9o5ys3OevxZ6J?=
 =?us-ascii?Q?Zb2kbjwWSR2ETlenhIbUCFL/uV5H45LFnaH3Z09D+7H0M3A/pplWUiQokTZh?=
 =?us-ascii?Q?Pqegu2n/c/frPnYoIQtmEBen9dqw1/5UQitF/KXprGmDDf+Hr/mKRUteUis4?=
 =?us-ascii?Q?aKP5jyM0Fkm82uejYWL316VrNrdU98crFWhWWcMihXFiS8URoY5DhVy1kpXx?=
 =?us-ascii?Q?YLSQ1JogvKyuWzncy61BudyoWdKjQBy53w19N5kAcAnI8p+WX8mGYuMOrWMm?=
 =?us-ascii?Q?xiHhpaw1oafN7slgX1ZkanNcNIfOA1DLqV4lJekvrMA8kGeV0pQX6z4FFIUX?=
 =?us-ascii?Q?9yCLf2QSVeHBtX5AVY6azdiZUWxsw7hu2q0N9pNNtQX8mw/8y8V5sibyys7H?=
 =?us-ascii?Q?rTSD3DS9vf4FJ7CFFtsosW1DHqNg9T9dHbl2DueuLAqQuh28FtGJkxdyYVXy?=
 =?us-ascii?Q?zkNMcbOoh+F84lKL5g7FSTki+2adk5Qy1GxWKfAuc6NSOtxpDe1buLAJt/er?=
 =?us-ascii?Q?rszImKvLYivpurTamPy9DT9FV8qL97NfyRLIf1pEnk8Heyno8XaPdksz7yND?=
 =?us-ascii?Q?VYMe4P0zhiay4Z4RRRk8G6cFrsbeScpdUssNQ04dcFjXBMxdji6ok1VUBNWT?=
 =?us-ascii?Q?AjIN5k5/KgKXVlvGUVDXYXvNUesk+OGQl9Tmwa4e2h5vxvvV641yk4eykjlM?=
 =?us-ascii?Q?bTbYH+huFjVRB6Y5aYQ2bMQZM2dclYm55kqjpBmIoG+c+KAjk43e5iAMVqXq?=
 =?us-ascii?Q?zZocf6lqy9530ouewbRQ3LpDuqFEqj2rBLlIigrmv66UbturRneFrPf6smSw?=
 =?us-ascii?Q?dxOY3dEbIx47m6gcCnfb+EH91l8GP0Rrxko7q5Jp?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7194342d-355f-4fe1-b535-08dab17ce487
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2022 02:51:59.5911
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4aK69pZ8Cw6M4LbMCF8vZS55e4Aow6aC41Hox9xIj07Ote2Te7IxV/MnLhUQwJr0gkYi/K+JXdWXkMvPTNQJDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7535
X-OriginatorOrg: intel.com
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
Cc: linux-erofs@lists.ozlabs.org, "Fabio M. De Francesco" <fmdefrancesco@gmail.com>, LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Wed, Oct 19, 2022 at 07:36:55AM +0800, Gao Xiang wrote:
> On Wed, Oct 19, 2022 at 01:21:27AM +0200, Fabio M. De Francesco wrote:
> > On Tuesday, October 18, 2022 11:29:21 PM CEST Gao Xiang wrote:
> 
> ...

[snip]

> > 
> > In Btrfs I solved (thanks to David S.' advice) by mapping only one of two 
> > pages, only the one coming from the page cache. 
> > 
> > The other page didn't need the use of kmap_local_page() because it was 
> > allocated in the filesystem with "alloc_page(GFP_NOFS)". GFP_NOFS won't ever 
> > allocate from ZONE_HIGHMEM, therefore a direct page_address() could avoid the 
> > mapping and the nesting issues.
> > 
> > Did you check if you may solve the same way? 
> 
> That is not simple.  Currently we have compressed pages and decompressed
> pages (page cache or others), and they can be unmapped when either data
> is all consumed, so compressed pages can be unmapped first, or
> decompressed pages can be unmapped first.  That quite depends on which
> pages goes first.
> 
> I think such usage is a quite common pattern for decoder or encoder,
> you could take a look at z_erofs_lzma_decompress() in
> fs/erofs/decompressor_lzma.c.  So kmap() is still useful for such cases
> since I don't really care the HIGHMEM performance but correctness, but
> other alternative could churn/complex the map/unmap/remap pattern.
> 

When you say kmap() is still useful is this because of the map/unmap ordering
restrictions or because the address is required in different threads?

Ira
