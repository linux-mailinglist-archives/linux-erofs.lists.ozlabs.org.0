Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id E9F5A950220
	for <lists+linux-erofs@lfdr.de>; Tue, 13 Aug 2024 12:11:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1723543886;
	bh=C1ZX6FYwumzOHKp4/z/1NDrPOLk4D0+5vOy4WC9WGXA=;
	h=To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=ZX995W5ClxeghqssBAElYsup1yFQhsDTz7W5TW/m5AzpOZwUG9VS2L7zi6O0uAEMG
	 UUBHWsyWQwJ2xCZkHh+g1ZAK+SAmzq2dDM44nufQCtEv9KaAmfphZe8oKNfTxz/x0g
	 SxQV3D7jFUOK2y/xB/n2h0t7ATD2FauVNQJRu8FHpU5vPKE2DaZqVTcvauQ5qFTIOk
	 Ouc9qIg8FmvAQKtDxAPkPY9L42d3YqfJ9UfXoiJGPKL0cqC/GjFasmGpMuhBHG3Ib4
	 qf0B3ji6N528P1lq6tk6YZ+cQ1nyHibX5vqAFOzpYuEujMNo9xoSNBthaAST9/gjCL
	 3oVDVe99JBWtQ==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WjnGk64prz2yNR
	for <lists+linux-erofs@lfdr.de>; Tue, 13 Aug 2024 20:11:26 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=vivo.com header.i=@vivo.com header.a=rsa-sha256 header.s=selector2 header.b=LITjT/PI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=vivo.com (client-ip=2a01:111:f400:feae::619; helo=apc01-psa-obe.outbound.protection.outlook.com; envelope-from=guochunhai@vivo.com; receiver=lists.ozlabs.org)
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on20619.outbound.protection.outlook.com [IPv6:2a01:111:f400:feae::619])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WjnGd0G37z2xG5
	for <linux-erofs@lists.ozlabs.org>; Tue, 13 Aug 2024 20:11:19 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T0a6dE5zEVkGkykF5Nln5VGFKqHDb39pmYhGk801aotiNmIeRW8BqZhLBsq3zWxJOAgeA0gncOeSGILX8dc61iTrc4ZRzq2P6wtM35XkbCS5gKVkXnkBClRVEsTkr3mlWWTbGo1UeNQoK1Ou8nHVxQe+E+wEw2pXJ0tZRILIRqRswGLArPLy1Wya2qy90Pe8Mkx+i6gfy+1rvlKnGMrMDn785iwE0tDCpiCTWZnYpaEUwNKi+xzHq/MoSo26mxObsZdpyRR1dm8QfmDdIphqATo+Q0kk5jTYTt9n3NAujrCYBzUlrDHFYSItsFgGr/jAIKFVaIhLMD90yx2y/UaAmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C1ZX6FYwumzOHKp4/z/1NDrPOLk4D0+5vOy4WC9WGXA=;
 b=xRKAEUc6+juTjcljS/kNs+mgzlWMp9gfIJDX0Qhd4qS8H/0NckENZpIpgph2Zq1XAXo3pOH19M1WZ8Nb5NlWmqMRh6XbDMWq/pUzcqQ5B/udxfbOQRAnLUPyxUgSXFMWsoL0XUzIJCpobld+48lH151BUH+GISKZ82YgL5R6bArvqNeYrpWnt962NVS0R0ScKH8Sc+V+DltClkrN2etQMf7iF3hfcA1uCGxQrw67zmM8pogZOQWH6P1KLF+IhX8EN8eQ1dwHgyrcIvfw1d06SBqRHIv3qsbV8ml6r/rtY8CsYrNGq8RmjPPT2vwV6wHihAfGrv3JYp6oUkrnQSpHfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB7096.apcprd06.prod.outlook.com (2603:1096:405:b5::13)
 by SEZPR06MB6600.apcprd06.prod.outlook.com (2603:1096:101:179::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.20; Tue, 13 Aug
 2024 10:10:59 +0000
Received: from TYZPR06MB7096.apcprd06.prod.outlook.com
 ([fe80::6c3a:9f76:c4a5:c2b]) by TYZPR06MB7096.apcprd06.prod.outlook.com
 ([fe80::6c3a:9f76:c4a5:c2b%5]) with mapi id 15.20.7849.021; Tue, 13 Aug 2024
 10:10:59 +0000
To: xiang@kernel.org
Subject: [PATCH] erofs: allocate compressed page from reserved buffer pool first if cache decompression is disabled
Date: Tue, 13 Aug 2024 04:25:30 -0600
Message-Id: <20240813102530.639975-1-guochunhai@vivo.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0021.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::19) To TYZPR06MB7096.apcprd06.prod.outlook.com
 (2603:1096:405:b5::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB7096:EE_|SEZPR06MB6600:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fc2cb17-56cb-4d88-8605-08dcbb803a8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info: 	=?us-ascii?Q?NTbV4C0EQPrOkBbewefIZPI2DgyJPkxnE2R8qYYZ++219bpqHfYC95XEhWxc?=
 =?us-ascii?Q?gF6+ASmwdouegjLbEyRc8IgAsP6qPNuxOJHKcNiroTU9zZyMAIcc1/BQ80JQ?=
 =?us-ascii?Q?raJQW7aAK/k+YalU42b84iWlYEgM2qWf0+Iil65SWmRan+kmzlfO9xA5MYdt?=
 =?us-ascii?Q?4Gay5LZBUczy0W/wU1EqtTjbs3+5/DAmYJ9/NOaA2CpZekoONSonJXqjccci?=
 =?us-ascii?Q?fhMsOxUNKbMFUs8j7uUQkAISejrgEC32k0nkM0DU50fVkyVSS0kxui6oO6kG?=
 =?us-ascii?Q?ic6CIegjOxUZRXM7hrM+H1v0SppS4PZy2hMr/CS8pdBX3n4hFqVwm2ckSvk+?=
 =?us-ascii?Q?h5jCBP3jbB+Fp7iDlgP2ZpyWmISpk/DO8LdcCULfFVAPONCeuRIt5S2DC7CW?=
 =?us-ascii?Q?dRf49Hc94HyHSH4dpB6GzV0SiUOPuXT1m2Z15pFYWaCVDpIT6iErpUFVsVL4?=
 =?us-ascii?Q?BTKzt+HE5MEOMtaWgYqnEK1qT4poWGSBoHHjuqMObpA2o5Sj9uGH2daiR3iO?=
 =?us-ascii?Q?xFWtCNyo5++3qGivq8j1qo5nB8XcKmMcKN4ZOaKutRBJ+RpcgJgSg/MgYf8B?=
 =?us-ascii?Q?dF2d2P6g8hf2uGtDwuOYRs0o6JwvMV9phg6vvREok01yrNJ83XLy/zdfdhek?=
 =?us-ascii?Q?5NLVv9LgRX0gQVVwR+2YxJqJFRXLRsFgJpv/AJX0TWJy+0d2ggwbdtQmjHpd?=
 =?us-ascii?Q?iGPIyjzj7zrjPnOnc7xNDH1wtun8DhddIu3cikDiu6g25fC4mxvJiksXQDaS?=
 =?us-ascii?Q?O3SABpvWxIPxH0rFQ8fOy+dlcZJz8Bz/kMIHGhNL/kDWSiJjjQSgZo2QwcCQ?=
 =?us-ascii?Q?ySstpDVmdzdM6qkSaH2DhhTn/vwKjnMVrhtfugK1qpBqzyS0w4Hur6nTGYlk?=
 =?us-ascii?Q?kU6wrbSwezelxlZnDX6fiMUf4mTfspYxQtbDUg48VfJz44+vmKPleu15hARQ?=
 =?us-ascii?Q?wS+KmUmp+/2IDFX7fY4ot8xj9UzK9nDqOUDkC6n2pQidM7ON+Kh4O/1NWS+S?=
 =?us-ascii?Q?fEFiaj9n/bDp0xjLWzBm1Gvag0HqCZfrmSgndwIaHgRmF90VCKk/CXPBNeYe?=
 =?us-ascii?Q?rC/HTVwIBHbmq/jKWBwcVSq6U4XRvyeZDS5gU/JDig63yVgDX6ESTOEJ4DMJ?=
 =?us-ascii?Q?4pDeRBDdhjY2Zk2zanpNSpiIistR5M1eMWMpQYA4bkfXDN+eU+b8BMYTyKYb?=
 =?us-ascii?Q?Z1cHcUqX28IJ5aFsbdf+kEyVN/3U70dY241PtTPh4f4wuPbK6uKZ38WSV7t8?=
 =?us-ascii?Q?DX555dZZRHMoCItYJoi/AW1GI5gF5Fou95U3LHWdj34BDpMJVI+kL36R6Nmm?=
 =?us-ascii?Q?4hw8ZkiJt15dlGmZDBx2O0IftWKqLpgrONSL877mgSZgxzFK0h2SMC2HMXII?=
 =?us-ascii?Q?76sMmRKZUqfmocHV47deyfI84B3OHhUgA58tgrOee4530Ngl7Q=3D=3D?=
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB7096.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?us-ascii?Q?XL4Y2CUfwv+T/0DF08ye5/ZA7jldPA/LplCQs8AIpfJx7Cyteyt4ZEb0uqOh?=
 =?us-ascii?Q?YUq+N2ent7cETspRu0LyouYxCVkRp0EUoRHrED6J/GOzMsqqIQ+/s+vOEqfo?=
 =?us-ascii?Q?HQxa6j406GM1CN+fjEuNy2EuCujsMcI9jgJu2XuVfgKl7vQ8MtF3vApuwcU0?=
 =?us-ascii?Q?KHRB1pS72oujAUvUwfZbkmx70QeuXRvYXk4ny9JAkgbilqD7UQzWjStjSGI7?=
 =?us-ascii?Q?7+BSOlHiwb/vONVV7dpiKHu9D2R01MPWW5/TW8biuLu6Pjx9EqcYMej0AyHu?=
 =?us-ascii?Q?pSAUlApjZim9yNhWQo0ZXkW+8AOvmuPQSDDfuN9N5LqLWt+oLZHpJ6+FbqQM?=
 =?us-ascii?Q?4oA0YAbwuClSiBo5EfVg8OFSQMaW0QF4Wa879zcK/1bPCL9rmKJDdkp4eTI6?=
 =?us-ascii?Q?+rDX0zKYXujhY+7BDz6qiWKSavAfVm3CsGKBcnSDil/VIa+uB4xzwbgxEXZb?=
 =?us-ascii?Q?Euf0bqnyZHruQkK/ZaSh3g5vK+GQCeDFkqPIka7Yg2XXdU64mRe4PjNdbALm?=
 =?us-ascii?Q?biw/ZmgFVPMr2SU8dVq83/HV3xxmEaGi5R3kBQ3aMPJg0JhaKXriFfFsl3qk?=
 =?us-ascii?Q?ogFkjb36Rh8tRzT/U0D9e5mA3ud33tYbZkglezJhDO2D2PNNs8ZLMGSP51Gi?=
 =?us-ascii?Q?Gf6XmwjI7rNUUS2hgqn5o17I69/sv2QOKftlgYGza84E3wzAWUfvvgTQn7yW?=
 =?us-ascii?Q?WR7+xmITwBEl4dyIsgOEG/hu1m1ADfvnItQxaHZHIR3ylGCyd5lqkWOWHij4?=
 =?us-ascii?Q?2NA8r9WiujKIHBlABm29mC+0lpPVlixv1JPSW0eG6og0hFLffPc/Mc4oySwU?=
 =?us-ascii?Q?+0eiZ8Aco7gaDjHUVVf+lBB1mephK7v3gOf2oAMqK3F8aQ5M0erJfHjwGZ1Q?=
 =?us-ascii?Q?ZKndwxXeddZmwLhZlilWsPQ2zsY/KnxFqgxSaH2NMJiEJvPIRjs1JWEgSimf?=
 =?us-ascii?Q?KyjOzZKyrO70+wbSNXjnY9vuA5slnDxvIbNWGkEdCymwKsCgmMRH1NPN515A?=
 =?us-ascii?Q?1h0QGqd/guG9Jl72ZWZ2yA+CTFCxU6PgTdMRSqWPOeLZSEebvWowalwu0OuI?=
 =?us-ascii?Q?Guk1Mb4IVFfB0ESKBtzU7T1a2lk9syyyUxVk1+ftkNvG8Z/dBNCOTp5yUJ7Q?=
 =?us-ascii?Q?af6os/THIHqKCaUNvZV/6J9jfsPmcePbHv6sHi+qtcmJ+bHQL73SD/ajvRmD?=
 =?us-ascii?Q?8ITqfZHK+WZQN6j0bKUUIAfVjVHhZpQn3khCOaMTeIw//ENKFRAzMzwrF5O9?=
 =?us-ascii?Q?kLT2oVGKB1p0yMBGlYpj6GeDwkU8vlBWiKidCnXcUNJ4XmOuDGGHCOGAOL2L?=
 =?us-ascii?Q?y6ZSks+aTCpjuwxqijPUmAfDyIgIgI/NxuvS8tAAy2dK8WZ9cwyHi4aWrtsp?=
 =?us-ascii?Q?3Dame+7Eo/7ScPmQwL8ksgBrVslAbkXKfdmdnnrTJeP5aFSqFPQnZrBxY0Q2?=
 =?us-ascii?Q?5cz4yl2NyFmBehze4uNIm8sPKS4VufHHfNXoXsD7ZqucR2ta9vs5/SEeODG2?=
 =?us-ascii?Q?1cLSdKy5COw3Fz8Ij4mx1kmDWxLu0fdRF999n+1W3navDUqxKQJwYByjz8pS?=
 =?us-ascii?Q?Mlzd5/H9lMGff0FQkpwLw5A4RjfQ+NsJ4RT+CuEZ?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fc2cb17-56cb-4d88-8605-08dcbb803a8c
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB7096.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2024 10:10:59.3975
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1CqzGzNEg1WRjArRsNgSnlprV4rz3/U7I+m3Ipq9pb4qTeVtfOSR7eH9XLn+R+vcqKJZtDBMSNNZ9H+v9hzMUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6600
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
Cc: huyue2@coolpad.com, Chunhai Guo <guochunhai@vivo.com>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

When erofs cache decompression is disabled (EROFS_ZIP_CACHE_DISABLED),
pages allocated for compressed clusters are freed soon after
decompression. This can reduce the page allocation time by first
allocating pages from the reserved buffer pool [1].

[1] The reserved buffer pool and its benefits are detailed in
commit 0f6273ab4637 ("erofs: add a reserved buffer pool for lz4
decompression").

Signed-off-by: Chunhai Guo <guochunhai@vivo.com>
---
 fs/erofs/internal.h | 5 +++++
 fs/erofs/zdata.c    | 3 ++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 45dc15ebd870..e768990bf20f 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -201,6 +201,11 @@ enum {
 	EROFS_ZIP_CACHE_READAROUND
 };
 
+static inline bool erofs_is_cache_disabled(struct erofs_sb_info *sbi)
+{
+	return sbi->opt.cache_strategy == EROFS_ZIP_CACHE_DISABLED;
+}
+
 /* basic unit of the workstation of a super_block */
 struct erofs_workgroup {
 	pgoff_t index;
diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 424f656cd765..b979529be5ed 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -1496,7 +1496,8 @@ static void z_erofs_fill_bio_vec(struct bio_vec *bvec,
 	folio_unlock(folio);
 	folio_put(folio);
 out_allocfolio:
-	zbv.page = erofs_allocpage(&f->pagepool, gfp | __GFP_NOFAIL);
+	zbv.page = __erofs_allocpage(&f->pagepool, gfp | __GFP_NOFAIL,
+			erofs_is_cache_disabled(EROFS_I_SB(f->inode)));
 	spin_lock(&pcl->obj.lockref.lock);
 	if (pcl->compressed_bvecs[nr].page) {
 		erofs_pagepool_add(&f->pagepool, zbv.page);
-- 
2.25.1

