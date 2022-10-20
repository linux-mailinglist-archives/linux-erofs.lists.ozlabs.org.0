Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id B35B76055E0
	for <lists+linux-erofs@lfdr.de>; Thu, 20 Oct 2022 05:18:03 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MtCTj3RgGz3c69
	for <lists+linux-erofs@lfdr.de>; Thu, 20 Oct 2022 14:18:01 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=XB6LR5Dj;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=134.134.136.100; helo=mga07.intel.com; envelope-from=ira.weiny@intel.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=XB6LR5Dj;
	dkim-atps=neutral
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MtCTY4z8mz2xZV
	for <linux-erofs@lists.ozlabs.org>; Thu, 20 Oct 2022 14:17:47 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666235873; x=1697771873;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=OY9irz+FwX4g+mZC2EUVo7b3vP0XeFPrKW4Zzx8Hyx4=;
  b=XB6LR5Dj77qkPv4YyGcUDTD6KI+5ijZA3vv1KbcLNZa0g8mVkcXkYgsy
   dbCwumkmaJzsSD1Lglj08VKUYwS+9VSds+fSGJArX3g5S1vwft4bawsir
   rwfi4Deu9deQjBKvIg92ilHcc9j/0kUh/W62ScGoBTN4zHtTRnEQd1Okf
   gOhTDA8K9XFfInhqJIgkcHlLgAyYlFPFU5cNQlv7sxAXeT2uhJNTCPh6y
   V1rDwPABgUEcbUj8KCN/a3lUbyfjxuXsP9GkQnRpPoe9rD68rZCgkyJOP
   6TWBIiHkr9LlJFjLuR1BXTza2IT+KGQeKecE2INNFb3vAoUBft5/2ib6X
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10505"; a="370803302"
X-IronPort-AV: E=Sophos;i="5.95,196,1661842800"; 
   d="scan'208";a="370803302"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2022 20:17:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10505"; a="804615720"
X-IronPort-AV: E=Sophos;i="5.95,196,1661842800"; 
   d="scan'208";a="804615720"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga005.jf.intel.com with ESMTP; 19 Oct 2022 20:17:44 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 19 Oct 2022 20:17:43 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 19 Oct 2022 20:17:43 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.102)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 19 Oct 2022 20:17:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dbmSddujV0DtZ5sq3HYWxcR9fQvzlPffGQwi2ksAk86rqH/tjnya9wzpcWYlPY7LwGXG1GM2hW25GmMYt8LI11U7meYqwMuRhXDmMGvLsiC4xN0pFkPI1wvh7Vkcd4BEX3RidOyvkchZxypRP3ERJ5iwzwZrcvNYwV/CWWLcUU6C5cAfWXS1xaL3wosUivusqupJjw1dXa0ufjFWdq7fqvia6tr0BQ8+NXRLC6h9xhA8dD1CNLa6ixvaEMh1iAtlB0e7Y8O0qIcLv+DjobSb2vtTvYTLi1+TtUTlHYeH4nKxuXSrG1cQYoQhevCLCz+uZIRLVFF5MhZo7W2UhDstyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A7AG2VJCcaW4jerCeWPeszyWYfygCqiiJgx/HLEMWLU=;
 b=Blj6F6qDy1rvGOLleOe5JmK6tbtWMBTMroStkrx5fmCLDimcmAvAqn64wlwAbwwOhVJ/ri+fwVZf7SIpogMgQVP5cjGFj/ZIL4SYsLJJp3+lvUOVjzjSJpKp7XLxPtwZ0DLezZTozA00ON/YCRNvsaZPr6U4xjw7XSMejQyri3gJ7wXU5KoNYJONuRrN4aiJC7PX6suzNtCvsZGGNTWsEy8NRKp56pJcod6hiCBFXSXIoy+5bNjxgLUCRghGmK6FLfK3Oxb8NDKLqG5pyoX8NhpXCsN8M0PuCM3lBh84J6qpCCJNz8d81YrTZf9nKXLKgbbPPWglXrgJzLXx05m/uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by SJ0PR11MB5896.namprd11.prod.outlook.com (2603:10b6:a03:42c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.30; Thu, 20 Oct
 2022 03:17:35 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6f83:c165:aa0c:efae]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6f83:c165:aa0c:efae%8]) with mapi id 15.20.5723.033; Thu, 20 Oct 2022
 03:17:35 +0000
Date: Wed, 19 Oct 2022 20:17:31 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [PATCH v2] erofs: use kmap_local_page() only for erofs_bread()
Message-ID: <Y1C9y2y/87tIgfia@iweiny-mobl>
References: <20221018105313.4940-1-hsiangkao@linux.alibaba.com>
 <2019477.yKVeVyVuyW@mypc>
 <Y084l0m88JGOqGRN@B-P7TQMD6M-0146.lan>
 <12077010.O9o76ZdvQC@mypc>
 <Y1Cv/LuiGpVdO5im@B-P7TQMD6M-0146.local>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y1Cv/LuiGpVdO5im@B-P7TQMD6M-0146.local>
X-ClientProxiedBy: BYAPR04CA0002.namprd04.prod.outlook.com
 (2603:10b6:a03:40::15) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|SJ0PR11MB5896:EE_
X-MS-Office365-Filtering-Correlation-Id: 14d4b096-0185-40a2-c429-08dab249a25d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ub7CGsXJ1PYDR8tzr5+rIo/+Zx0kfux+CqUx8XPaluomWS7N30FIWyxAE8reE06EwREiLW88c5hV19xakblnb6tMHq1Yj4aKOjfYCHVKXodzWEkP2PWMxiYPiLp4gsgmu9BWD4YWAHZ6Sqo8vJ7rBa8bk0mKcy+QHrYx2wPihWZcgpDX1acz+CmImNznkQ1cZ2HGRtUuUvtBbediFeKA5LWaZ55Lr4aRyMxvPVyRpD0V+4Yybxp9qkYiqBleMfVLPRrXIej2xjcLlW6yRGvAMug2rdZ5BCB43getjdeUxCKH3zv9A8llxaIfp1LkbwlLQB2/NuEeu2fAnTZ4NUuxgkvXnaoz4jS/+p5+WrfcNTNDtu3Q56lKtFHfP0FYn+knKhcnCDhXk0uvMz0sUwrgN2HKm0wYpmwS9TuGy4IEsKQkR8XR9kngmGNVE1tLQHccROE7KaddFxNHmbHbEPUoVCnRegIuTUxgiV0UWSgLPwU7CwSwMvQIBGG/B5oGmmR3ajQxtMPXABHKoV4ctov7u1uJClRyu0ZOkUke+KnIX7ucdemKdwIuVKl7HMp4HZCw2yn0rmTwKR/hMH2J0KHVds57gaB07VS6C7kByFwgruV2qzbhUBNZTgyXmAc8bii6A503ZEVsv5+ebjnq4FOHgW2mXgiW26MgH1x6taHollpZsl2Vg4gR3OnBudRMRebORpuF8/bmNxkWgjoehUSP/Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(366004)(376002)(136003)(346002)(39860400002)(396003)(451199015)(316002)(54906003)(6916009)(66476007)(83380400001)(8936002)(53546011)(8676002)(66556008)(41300700001)(6506007)(5660300002)(66946007)(86362001)(26005)(9686003)(6666004)(6512007)(2906002)(33716001)(82960400001)(4326008)(186003)(38100700002)(6486002)(478600001)(44832011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PBV/K+bLLa2fF5zQ+5Cjz3+ImfpmmO5SDoJ2N/5ii/JHJMsQ/BzhhvKsBPnZ?=
 =?us-ascii?Q?cvyFxIUmcR6PY9S78oftKtbghaX9wOBr59hNC/3gfszt3BBdD3/QhrHDJJ+j?=
 =?us-ascii?Q?HKcRU4bsWJkPk9lLX4GVMGPufpy/STKB8F8TPwUxv24rv/4YJWIWF6rMruOC?=
 =?us-ascii?Q?98CSZvjEeX/V5L+t061gSRMGDGSzR18bPDz3sGXEANJ84TJMRR97xDEVySzh?=
 =?us-ascii?Q?v9vHZ/amJ3erQvgNvYRWfwnm4OUebOyRqhjC/KWCYNApUJMcxeAB9UA22sIk?=
 =?us-ascii?Q?4fZYiFqYKV59lpT3dya6edjG+1dNenh19AK4bruy//fJH3We4Fz8PglFTwPG?=
 =?us-ascii?Q?5q7LTqfATJdS88TZnIZ1TksVMt/lgV8dVCGDu1xP9D0fmru3x2b739Uld8jK?=
 =?us-ascii?Q?VIPmgrge1QCjVKBltlVez0lRndu/dGp1HNEVdnhgr45NMAuNKagtpPfTJPxJ?=
 =?us-ascii?Q?b8FyK4KEuMwJJgxv/LM7YESPrFzs/QLAVlQfSs+mW4HML9mHXpNw7PHDo0Rb?=
 =?us-ascii?Q?D9CQI1QJpKkWtpiQoFGwCkxFsQ5l5T0rUpm5IYopD6CvH+rFX9ux6EVKb3pH?=
 =?us-ascii?Q?Ix9xZbxnscGdu8aigsKhixqWQ+HTfXLw90HDRZj/u08PRvr/7WlGtINDCAkd?=
 =?us-ascii?Q?dstKReUPkG6cYPeA11NBmJ19QU2/OBvWEaMqoWf/Cbqw9F8YLYoMwayt0qbK?=
 =?us-ascii?Q?e2FT3hmSzlEIOW3irz1JNxImiOGgWVq32HILCsDZnuYR2qjwFxvn2Zq9ZPjR?=
 =?us-ascii?Q?H5GOd7OaEIZExLlGjLwVquJRNkMO4gjHrMvPa/rnq7M65L2MvLhm9ruHjfh8?=
 =?us-ascii?Q?1hOxMcvnS7q8HBW0cWntV3qVbjushnSGtIV5oI5q5g86YjOwGFsXNwnqP5To?=
 =?us-ascii?Q?aLXbenLE+xVuMVoAoJLgR6JOJ96fRqso4gqSK5fw7l7Q0n4Yd5DC/aYkHjF7?=
 =?us-ascii?Q?aw+IIxusaUHBgWnF2ImI5fDr7b13tXn6VX8t6oC2dDiZqy9aGPvqEhHJjift?=
 =?us-ascii?Q?OTqvDzwurz/tIaJhd4/Jlp/CThzeSX/efmSSj53fqz5huuo56cQgwDWlvhRA?=
 =?us-ascii?Q?NxghUaKOE0qYdkP/W3Vhbvvl9d38PyOvFVIa4Xf6aFIi0PGr8stYZ1diTw3y?=
 =?us-ascii?Q?dc03FotOjhbE21yzfGm3z71fco8XW/Ai2C8Fsg5UGLHYooRDzqj5Y/s4FB69?=
 =?us-ascii?Q?MDuLU2VKnfh51igg+ztJ62hNrqJrorGTlX2ZYA76MqYBgINKsDfTWlhwXU97?=
 =?us-ascii?Q?dqxEuECqFcfxeteOUCcptLDDhPJoDk6XhMRCTjH+geyMWNz5b9agZU+YFzs0?=
 =?us-ascii?Q?mSpyeuO0XXSJx4XXbxVak+TaIS2YemHtq1wiWn7uACYleAADOWd8gdQWKB40?=
 =?us-ascii?Q?ii+5f7UtSZz2X3wPe/+BVz0P00yhto7g0pIC1G7I5wBHZzXyA3tGZxiGt+xM?=
 =?us-ascii?Q?T5ZVKuRIdSMsmCfgQr+qfxUq3xEFclLrMDv9RgwpJx3JPW4wG9s2Xkqzg9+N?=
 =?us-ascii?Q?O3St1X6Rslfxq/6eHWhcypdUlOpYFlYtu1cEu0Y70lCTEC1XilEMpyqmrtd+?=
 =?us-ascii?Q?qkl8vxV/S2ErOYpZMNdFuXPfdAviOhmLFHfmuW1A?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 14d4b096-0185-40a2-c429-08dab249a25d
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2022 03:17:35.4319
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4E0/LnDsX1Jtn6GxVkXJ6OGy7mJ3Whs1xmv6h/mJeQNqUK2ygKqj2AlmGjNZkjTB+4olvemMrgFxuCM6MMKTWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5896
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

On Thu, Oct 20, 2022 at 10:18:36AM +0800, Gao Xiang wrote:
> On Wed, Oct 19, 2022 at 08:17:05PM +0200, Fabio M. De Francesco wrote:
> > On Wednesday, October 19, 2022 1:36:55 AM CEST Gao Xiang wrote:
> > > On Wed, Oct 19, 2022 at 01:21:27AM +0200, Fabio M. De Francesco wrote:
> > > > On Tuesday, October 18, 2022 11:29:21 PM CEST Gao Xiang wrote:

[snip]

> 
> That is not the simple nested unmapped case as you said above, I could take
> a very brief example:

Building on this.  The uncompressed pages always outnumber the compressed
pages, right?

> 
> 1. map a decompresed page
> 2. map a compressed page

First reverse these because you are going to need to map a new decompressed
page before another compressed page.  So:

1. map compressed
2. map decompressed

Then 4/5 and 7/8 become unmap/map new without issue.

> 3. working
> 4. decompressed page is all consumed, unmap the current decompressed page
> 5. map the next decompressed page
> 6. working
> 7. decompressed page is all consumed, unmap the current decompressed page
> 8. map the next decompressed page
> 9. working

This is more complicated but not overly so.

Simply

9.1 unmap decompressed

> 10. compressed page is all consumed, unmap the current compressed page
> 11. map the next compressed page

11.1 remap decompressed

> 12. working
> 13. ... (anyway, unmap and remap a compressed page or a decompressed page
>          in any order.)
> 
> until all process is finished.  by using kmap(), it's much simple to
> implement this, but kmap_local(), it only complexes the code.

Agreed kmap() is easier but I think this could work.

Basically you keep the compressed mapped first.

I also assume there is also a reverse of this so reverse the pages in that
case.

Thoughts?
Ira
