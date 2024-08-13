Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 861AB950227
	for <lists+linux-erofs@lfdr.de>; Tue, 13 Aug 2024 12:13:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1723543990;
	bh=mBXElhS15UTm1bK6pt6zM7SJYFdnI6KzZ3b824N+mbs=;
	h=To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=gN0EcdBigrGUZJOG/SLeUNifa0UJBeCM7YJes+WG+oD7vL+3hUWUPb6rAFbYPO17g
	 wD7ZH9OL1j9FEIWIfL2bMYMG7kVJhUUhexGF+zccWDe2IOZuLpTkAtUGEObqCt+Wzw
	 5QP3G9R+UNnAd2CrRxfbUJ5r5hiPEYYZESdju0pbdvWbEkua1kjm0lWp0xDwTcF2dv
	 4PVI+XaFRSxqDQCHs9fE6RlndWHWiSBEbf7RhvFLMrOOnC9pBB2CHMNegrQXOh7IpM
	 aqw/+nRKmcLNc//4TX7Aj0QIuNLruVQ8SvaVNhZpGe8QyCZSk8pL7PFYA2wVrb0ZsB
	 6FaJR1fBxSzEA==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WjnJk3Cd4z2yNR
	for <lists+linux-erofs@lfdr.de>; Tue, 13 Aug 2024 20:13:10 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=vivo.com header.i=@vivo.com header.a=rsa-sha256 header.s=selector2 header.b=cqnA/f5X;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=vivo.com (client-ip=2a01:111:f400:feab::62f; helo=apc01-sg2-obe.outbound.protection.outlook.com; envelope-from=guochunhai@vivo.com; receiver=lists.ozlabs.org)
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2062f.outbound.protection.outlook.com [IPv6:2a01:111:f400:feab::62f])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WjnJg016sz2xG5
	for <linux-erofs@lists.ozlabs.org>; Tue, 13 Aug 2024 20:13:05 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wr1Y7Oj9Ynv6BOwI6EuNQkO2WEJFU/abmyCrUT48EnbvfJabymHFFpe+oQAFRHkkMJxqZ+K44+EegJ0c/uJglH5aHv7pX42vRN+EJMeROYGD+KjwH8z0fEl/HpH3BPR1zPJY1Icul8v/rFf5VsUy6NkLSNdA+g3f55PKWJR5jrHJn8JLFepjSZ2lxKUDpa83uBfDBtA+weDz0/isZHAMowMgOdrN04JZyhfORu8tM9oP0jdzm2Vj/J+mXMzvlsBw+Io7TCBVh9tXcTOOD/Oqu3iKIby5JDZy9g8HwwUsYiS00xYzft1Z0OtbRy5M6J8HTMFEUPZGPy2l6LR4r0RZaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mBXElhS15UTm1bK6pt6zM7SJYFdnI6KzZ3b824N+mbs=;
 b=YrIlaHi+IzzcX9bw+LOdCGmlfssYu0VG1Z7Qbb/VdBWFyKDIez/CmSTDBtCpJeM4iTkq6WN14zHdl9KlJZZCMMIg+uWWDsRAaja+GG4kvUrZcMvYp9s0joRxq5Jdedfksga/UD4cEJH/HltX84OcTxp0r17lNxBzOUrdyZqQRXYopI9yDUKVH0mhDwRKU1rwJ5N2Oe0tkBUcMS/hB+wG2LLJEbwLsRMQ4XtekhJxxZ+H5jrdNIwqBXB89g6qekLoxqXO2V+YN5ySRJ0Dppa/8OxQguJZ64bpZ03RR8Wz+lPA7SBDIftCUr+OMnCE6C65qWJ/O/V/H4lYcJ3a4896xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB7096.apcprd06.prod.outlook.com (2603:1096:405:b5::13)
 by SEZPR06MB6600.apcprd06.prod.outlook.com (2603:1096:101:179::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.20; Tue, 13 Aug
 2024 10:12:47 +0000
Received: from TYZPR06MB7096.apcprd06.prod.outlook.com
 ([fe80::6c3a:9f76:c4a5:c2b]) by TYZPR06MB7096.apcprd06.prod.outlook.com
 ([fe80::6c3a:9f76:c4a5:c2b%5]) with mapi id 15.20.7849.021; Tue, 13 Aug 2024
 10:12:47 +0000
To: xiang@kernel.org
Subject: [PATCH] erofs: allocate extra bvec pages from reserved buffer pool first by default
Date: Tue, 13 Aug 2024 04:27:23 -0600
Message-Id: <20240813102723.640311-1-guochunhai@vivo.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0019.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::31)
 To TYZPR06MB7096.apcprd06.prod.outlook.com (2603:1096:405:b5::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB7096:EE_|SEZPR06MB6600:EE_
X-MS-Office365-Filtering-Correlation-Id: e9e40bbe-aa42-408a-bf0d-08dcbb807ac9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info: 	=?us-ascii?Q?lPsA3BkHtkKiF4ZsAXdtIzqY3BznDD93Gm4dFFuzLbpVRTm2z4pb7arjkWhX?=
 =?us-ascii?Q?TbOiDELuadMI+q5GC96ijRu2Ld6FCBAGAOh5iyUImfBDOI00LtmhT9zVVnKd?=
 =?us-ascii?Q?Ugv/QfCXTT1BLkHIX4F5AalU0HWJ0USxV/MPFLNrNcKBb+m/XfgRGnMEA5Cu?=
 =?us-ascii?Q?LtAQPYwnLOtaSs+w1QtIDFJ9mertGdiRq4o31feWNwLOtouzYWPN0b7/2ie7?=
 =?us-ascii?Q?SKPya7R0halwfkXBQI5Af3wkXTzZa4V9lsxkdulnJGiKwLNOfAGh3r0yt8lR?=
 =?us-ascii?Q?Z+FHWBcaixMep9Hb+Ufz8gLcnVCuTK21rwqnWGgdSNC2xfFY5s09CJP4H5OK?=
 =?us-ascii?Q?L8nLlCZbjtCNJE2+2fGFJmbOabL5AESt5nww2229Yyg5stGAiszXw+dkki/e?=
 =?us-ascii?Q?eXDvj1xCb7kvp/vynmIMzp/1Ut93m1jyGMBo+1AcWglndzIH9lgmNbmzvXn3?=
 =?us-ascii?Q?52fmym7qXzLbJCd0ZfXhaZofOj8x/Ls8j6Mp7iNgsuR8JXLDJ4xygLqnHst3?=
 =?us-ascii?Q?VYO631lAZd3sLw41ifYMIT9mXI3It5W7rmNl/7O6VX4Oeg89+nXYm8qtW1xm?=
 =?us-ascii?Q?hGAkR3/VNaw0oc71xOxL3WZEb5Ms692ONuoEORFpv21OGlB1kkq4EUXhoU4F?=
 =?us-ascii?Q?TN4fn91EZwiYLtCgqXIDB/rf5H0BL0gt5+rmspP2j36xuv//Bg+Ljqoe7hlu?=
 =?us-ascii?Q?FlrTw8oCX1rG8y42zzCdV66M2TvcYFGE7aKkIiOdiMxxkScrTvUo/FyoQtYt?=
 =?us-ascii?Q?Txykl0NIXdPZKsIQ68Lq+NWSw1eiyi1+Kn64IquZO/annmZ/FHNFCdxqCFwf?=
 =?us-ascii?Q?2ENAcJvVkeUGoSwHAGncetIbErghRuNNtHvVKRCJJHYpUlXWJCINkfUTrnle?=
 =?us-ascii?Q?Qr2sUMrJg4I+i466FEWxlqx/PPKyWyTOCc790Sl/0cV5U3RcjiqxeGIZMRn3?=
 =?us-ascii?Q?mJpKk6mMfw37STy8oQmTuYCgSe9Yoi1xCoJXZ3euMq+OlZmrPwVzxqLPIX0q?=
 =?us-ascii?Q?3mYlgoHHd7kAhK/ZA844/RUdUSfyrRU1tItzRXyKJodLQVvMDbHDMeSJIkUH?=
 =?us-ascii?Q?douvJ0EYYeacmuy64cy5uq/OCt6vMLmTzIxr05iMd0o9xdzyVlXqaAFd0+gF?=
 =?us-ascii?Q?IVzKy+cA/5FkyQZF63PGoAgnU7JqGDB9uZQDFLDmd49OTCIo43yVTNVM5Luu?=
 =?us-ascii?Q?lX3cKjGbLVuumtFGD9dtSOOUtJGx6Jq3xKhnS2iPt79RnUa5GlE6gFsB3D3j?=
 =?us-ascii?Q?U/3N8D6YxbEDk7rZsCSDOx4XNxKrvHjbjz2cg1rOS8sOKJUaZaRyROZdjLME?=
 =?us-ascii?Q?UGT8ZTE7pYvAr7uwazl3VkAkF0GJjIbzAPAmwsXAUVQSQOdFuyYeOqoy5XpS?=
 =?us-ascii?Q?IW2XImIKv7Kok0PS3gnuJwK9weVMls55EWX21TogI8MyNzOxQQ=3D=3D?=
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB7096.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?us-ascii?Q?VFms+IWCsGacW4lAf62pvHVbLnbqZ6zOJTGn1lrUpvE0GuMcuyhYPLGSn0ao?=
 =?us-ascii?Q?y9zY64Y2Q2Z6E1s1QyAubnpa+MHqiKflDK6Em48Rqq8HAVIskqr2Q9aIkoR0?=
 =?us-ascii?Q?bifXr9S9wY5qgpdm7ZpomdsYtKPAL9kfMXyU0IVBdrPbHdzoZGJn/a+axg0Y?=
 =?us-ascii?Q?IPGGM4ztTnFzDTLY75Ce1AaJJDvEwpehX9j2OLOPwCwRKnU0lomlJCb9n8Ir?=
 =?us-ascii?Q?nlaIEvV+DUN+P4Lqk4RIteWz/6Wmc61Mzo5uwmQOYbb/9U/fM0/dFnE9cySI?=
 =?us-ascii?Q?RiR6AzM0/V2ZQr+NKmI+vCBl4bxXdHsJnvX46zwYbqYYFhniK3e5yrC/rpCT?=
 =?us-ascii?Q?bfx0xrcO0UpvsRqUgFC9oUEJYEtK2GQrh+vfeDPjikavFQ184LNH4poJPt+V?=
 =?us-ascii?Q?O+c8jC0UvnW1s9hvm/qIHsJExRlcr1SGAtQDmQgIlUymF9syKNKhxUUjPJ6a?=
 =?us-ascii?Q?JBiafdV4lKyXMfBeOIn5GULyjtUp18yK0GzGTf0D/lTq6bvzi7VpxTp8DrgJ?=
 =?us-ascii?Q?M7OvBZ+4Zcng7DvbSi6orES9+QKpIixYw9eKEVbUy8245vqC+yHwJzG0rdKT?=
 =?us-ascii?Q?Tyj4CqHfzoDgmpC+Zpm0j4CMcgA1PaaXWfRtCdqLvatv5l1k2Vt/azfKuNAF?=
 =?us-ascii?Q?iMvrE+5kgZXG2z3xZni9x18Kw5whV0GG8lUrm+2en22TCGIg8DleAGpc/E1x?=
 =?us-ascii?Q?6rvXM/oTW7+sMjPO/DAv27Bf446qynRpeBVM1PImnNpXD+JzpyifoU8R10Ig?=
 =?us-ascii?Q?neMgdM1/ZgR83UA/jX2+sjtBLtJuhBzBtv97FWef57GckCkPrV71K6zIaRCf?=
 =?us-ascii?Q?nowyvw6UOhFKAf/tAA0qYIoCLAUebGRUeHN8aAwV00pCxJeZSDUW3cCwlcK4?=
 =?us-ascii?Q?cmr2SwpXv9o1M6mz/1mOVRQP2+P5QGdYc4pGer4xG6tOV4yNweg1t4dNF49v?=
 =?us-ascii?Q?5YKjW9bHKIYY7bDmlCStVUJWPiX3QnI8NRat4cf0+th8gR8PsiXSjmJLixcH?=
 =?us-ascii?Q?Ec/9GN4hrAXKZrj/u92E9I+cN3WO7g+CyAVHP2VF+CY6wYvxt8eh484T9uir?=
 =?us-ascii?Q?pUPSKKFeyfyWef5jtsT26ePKzpUa9fr01NUSCKzOvbO0d2eb0LQESM5qRAv5?=
 =?us-ascii?Q?7i+lpjen166nWn3Lh0OpUkHLOvU27XW8rHtt6LDWfuXHvioctmAsLKtRNnYF?=
 =?us-ascii?Q?PR0VBXy0auUv2RDu1/jfOw0N2vUQI6i+/GkaHVg8h4DNAg0yDsKs0rhvAYyh?=
 =?us-ascii?Q?yxtwI/EgryhMbK0lYzz8YkM/y5GI3S307m+sXVwho3Y8K+tJLhmbSUJ9YUQL?=
 =?us-ascii?Q?bNXQTLVn0GyGgEc+76jdCebKElOZkjBJlMkhUjDUC+og5t36WJTWQ/drojjQ?=
 =?us-ascii?Q?50uQpi6JsAfQo5v/SPAFwcqJCmHa9hu7vLm/8UCwQYaxqGsx+5lxF0kfz9tk?=
 =?us-ascii?Q?Bos9upryXaq6nwvEuAbNx9OQYf6AB2Ai/gDaX3O7ONML4dgLvC+AzTMA4tGF?=
 =?us-ascii?Q?8oebq12SdKH/UjbuFEtoPeDfGSx39Mukd2StiX1LxnG2vecNqqbZPebYmZZl?=
 =?us-ascii?Q?RBMocaEc3+n/7Du/zhVMizoorNxsU26FizrKvW6x?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9e40bbe-aa42-408a-bf0d-08dcbb807ac9
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB7096.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2024 10:12:47.1832
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nT0yZmew2Fx1SJqycP+ofWcUFu3CfrenPPZ2bo4In4HeVSYE8jqe9Jc6zu94ny0/ksXIK2UQlaOJcjNgexViIg==
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

As the extra bvec pages are allocated and freed in a short time, it can
reduce the page allocation time by first allocating pages from the
reserved buffer pool [1].

[1] The reserved buffer pool and its benefits are detailed in
commit 0f6273ab4637 ("erofs: add a reserved buffer pool for lz4
decompression").

Signed-off-by: Chunhai Guo <guochunhai@vivo.com>
---
 fs/erofs/zdata.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index b979529be5ed..428ab617e0e4 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -232,7 +232,8 @@ static int z_erofs_bvec_enqueue(struct z_erofs_bvec_iter *iter,
 		struct page *nextpage = *candidate_bvpage;
 
 		if (!nextpage) {
-			nextpage = erofs_allocpage(pagepool, GFP_KERNEL);
+			nextpage = __erofs_allocpage(pagepool, GFP_KERNEL,
+					true);
 			if (!nextpage)
 				return -ENOMEM;
 			set_page_private(nextpage, Z_EROFS_SHORTLIVED_PAGE);
-- 
2.25.1

