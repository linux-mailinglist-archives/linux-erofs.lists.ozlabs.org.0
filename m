Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E2973EF984
	for <lists+linux-erofs@lfdr.de>; Wed, 18 Aug 2021 06:36:25 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GqFTg4071z30J5
	for <lists+linux-erofs@lfdr.de>; Wed, 18 Aug 2021 14:36:23 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1629261383;
	bh=gaKOOXa40kzzvyevzD+iQ53oN0bsSSNAuKgdMHsYL4g=;
	h=To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=MrJx1BrZbEKEMcFjej5s/eEf9Sn/oHibJbsIhI4puVqDJf3BUoGmIfDX51Pqphp9e
	 zIrdAqGAhrIlhtj3fVFGoiIG/Fvo911B2PFtlLuA5LntPLNKziKRCc6YjtT3rWCeM9
	 KsNVWQmIv8iHN0ZKKju8ENVmo3UHVE+BDdt6OM5M3U14gUHdIerDJl9Fd7c8sN+iJ2
	 vl+Oh4ncWPbHJvgRIJXJEg4uIbmoEWMc5ErQyuqE4HO7lml51bj25b2aGg/R9lnleE
	 uIuT4wE51H0oOB38Q85dFbHJDoJRpTGhuKgBztLSNd4S29pXcXfO27i1yOxW369oCw
	 Lrzag4TBjVjCw==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=oppo.com (client-ip=40.107.130.71;
 helo=apc01-hk2-obe.outbound.protection.outlook.com;
 envelope-from=huangjianan@oppo.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=oppo.com header.i=@oppo.com header.a=rsa-sha256
 header.s=selector1 header.b=wEJsJPch; 
 dkim-atps=neutral
Received: from APC01-HK2-obe.outbound.protection.outlook.com
 (mail-eopbgr1300071.outbound.protection.outlook.com [40.107.130.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GqFTc5F3Dz303f
 for <linux-erofs@lists.ozlabs.org>; Wed, 18 Aug 2021 14:36:19 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mZhvUt/Mn6AVvrRJ5KnOXFw+HyFQJHPY7AqnPm7aQu/voyA/HitTeWkF2rkBuKAQrytsZn9dyMFsQAEz+1QXXBbqSFrAqPhkh0yaWYmO/Bh5+JlJTCDt9a5g3/J4Ji5kV9brPInsDpytzzRhwIHEjMdGstwAzTn7JnyDJSEGafFN5aqiT2cAcLGbNqpF1zrzqjSsnfqpufbMCk+YFnp3cLTPtb2Nl3QoDyHZZyQcWXIGZUwe+oc9x+DXD6eIr3DQBECbl5d2ETGPB51RqoEjG2tXB2N2WX/4jrgD+ripUyLaPI3cjqEEZFgXurL09S119ZWxsl8w/9/fOR6ZiCl61A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gaKOOXa40kzzvyevzD+iQ53oN0bsSSNAuKgdMHsYL4g=;
 b=iDUVDdeFzq0C9RwP77MOTIb3tVCih0GqLYw1bKq8UgBpj8fU74I4BozSATUwIZjRShTn8bm0/GmdjLpF/I9vKc2v6PDQA8Tj+FyJi6ywp3AQuK1METF8eAYeNz62Ocw9lu3IL7Vhy5gGlqbdyPjZNI3uT35tZAvZQ7U7fGPAiyb77u2ujfITFj75HRybSik6rxHXqpfPwA5ZDpm4EhmMsar1hFPGa1DPO0fWIkJaj4b3FFf1kmxnN8jCJVPrFZHh56WU6XPN2SMshym11OfM1XKBfbMvbNIusvziozypTyEH7zDvNNbixwkHctI5u2ig7hi1ZRnoDUmOCyDJjpO6mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
Authentication-Results: lists.ozlabs.org; dkim=none (message not signed)
 header.d=none;lists.ozlabs.org; dmarc=none action=none header.from=oppo.com;
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com (2603:1096:4:96::19) by
 SG2PR02MB3943.apcprd02.prod.outlook.com (2603:1096:4:2c::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4415.18; Wed, 18 Aug 2021 04:35:59 +0000
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::98eb:b373:a778:a6a5]) by SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::98eb:b373:a778:a6a5%7]) with mapi id 15.20.4415.024; Wed, 18 Aug 2021
 04:35:59 +0000
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: add mkfs.erofs and erofsfuse to .gitignore
Date: Wed, 18 Aug 2021 12:35:39 +0800
Message-Id: <20210818043539.25417-1-huangjianan@oppo.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HK2PR0401CA0004.apcprd04.prod.outlook.com
 (2603:1096:202:2::14) To SG2PR02MB4108.apcprd02.prod.outlook.com
 (2603:1096:4:96::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from PC80253450.adc.com (58.252.5.73) by
 HK2PR0401CA0004.apcprd04.prod.outlook.com (2603:1096:202:2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend
 Transport; Wed, 18 Aug 2021 04:35:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 05e6cee7-d18c-416a-a0a9-08d96201ad60
X-MS-TrafficTypeDiagnostic: SG2PR02MB3943:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SG2PR02MB3943B9B685EAEBF1C5073289C3FF9@SG2PR02MB3943.apcprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1051;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kdD17cF2z/MCORd7PrFYUF2fHZBD8EUO1jZpNucRD1DRy3yFZUOARDRiO6rcPxQvKXdaIoMuFvcj8PyThn0s2+KTIYAuG5Pd0qcEwTJN/9UaCwJmtg/4XLVfBexqctRLhaqjuR72MpySeJECmGJ3ZMozSYhTclG+m6L79nKW5lf56IZNV09+Rmm6MMpPYJYtgfdCbfY0ka+szmYa5mmpqIKVwECGwA5JN+enyEob+26ZJEnDMN4LG8cyJYADcvjZtlranaIk5eHQhRcGF4jS+K0GetuANMj5oZjzOXFPt413/r7Ie5Wxf7tTb/610DWT7B0e7JJIBay8mnhlbBdfVNxIMdLfgU+TIknUkELTIMinbYvnMNRnnRnh4T0xz1D6k1uCKyu4FVfTUmgpSSmv5+bdwYQuLrBnS9LUF0hegQjmYqfrm800fR/SKgW/dOkBaVk+Qz1jtFN1oIQLhnG8bg7ykEW0Rl25vWtxvNckIN4/5aMM1pRGPdnHSWxcUwKzBVCPu2gQ6BCR25ID7tXCfw1yaksZd2bjdq8cucXDjATuGX+b0NGyejX8ebA90xMZfRtHQeL8yjlKjQBx9uBWQpNqDRoJwG+1Pc1O/8kkkSMXtkHeDAykdL57Tw3WKtauhzx2ovXWNx2ooAP+zMm34fErOxVIhaG/Oowx7DfeZNshUEHXAzag3x20Bd4QCYIVYRY5ZOjYX0h2Y3DZ9ZHDpeyH42mmJeeHUKWFKxLotfzlJT+/W7TID1h65oBxbqg+
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SG2PR02MB4108.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(366004)(346002)(39860400002)(376002)(38350700002)(1076003)(6512007)(38100700002)(6486002)(2906002)(8676002)(66476007)(4326008)(5660300002)(107886003)(956004)(186003)(86362001)(6666004)(2616005)(6916009)(558084003)(316002)(66556008)(26005)(52116002)(36756003)(8936002)(83380400001)(6506007)(66946007)(478600001)(11606007)(142923001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fAv2zPiEqrEGq8I26yc03fbWIN1FzdlWbljQ/7to+CzWKE72bdAns3pzHIro?=
 =?us-ascii?Q?iZtzhqqlv3gJ2ACM7uM4I+LfmgAlTva+iSbHK3sTeJ4Qn/IHTh/hUlhHKHcK?=
 =?us-ascii?Q?8DSfPI79nQaHphKGJrkvULZ433ULZZvswzB4cM7Wj3azYamlOA3JKhlwXEcU?=
 =?us-ascii?Q?SL4FJXKyF78B51bH9bfj+IbvrGKIWemEpXwhWdp4ss9ApsyT7E+v+d5OaBE5?=
 =?us-ascii?Q?XIvp8g4HMjw32/8Nfcn1wP1tH0GVhPvWVKvcFLYZwZ/po+0XolpEmtNpaVVj?=
 =?us-ascii?Q?31SzKMnAxfkhxSwijyBVAcb/+py0t68uvpCBVJDflO3oFNmv9JwHu116/MqD?=
 =?us-ascii?Q?HYb+P+SjEXMWEYmlfYAoYKoamPrVkuDjQ/1sT6t9PWWxdV9GbKe1urr55dhd?=
 =?us-ascii?Q?nJz1fQY/jaMDGYPzBTzAzT1/G/rS4Bz3ate8TUiZ1N4kHPHeqUahKJ8+1mQ4?=
 =?us-ascii?Q?kMfFDM6z6Ai44R7Me7o/fiDew7Bsnyf63UzaLcguapifkfXtgoVHKc90KGmU?=
 =?us-ascii?Q?mN15asYPxJVrZ5ibmWIcb2tGtgPFyDd15LuPlpk3I6SJQUR2er9ktE9KAjy/?=
 =?us-ascii?Q?SjyRuy/nethi/PkLRG5MPoxJ79bYDRf8+X9EieVFhczbrDOxoBJ+tqwqNtYL?=
 =?us-ascii?Q?ai5p7ZVUFR9g/cU/xWjIrlZgMiLC98RpQeFsImSUWWILXkgOJeDLqe88O4ct?=
 =?us-ascii?Q?nL/Eqrj6XSDWMRkdeiPtK3ZfvQeKTe+GW6dJDaAKpzgfs4OqMZzssvr1V3gf?=
 =?us-ascii?Q?YgZ+07sNi7QuXeAGe/GumvwrFkkwm28qfQc313pALCU5+xW8U4X8dKS18PV/?=
 =?us-ascii?Q?uGoo+4NA7MdeUA7iAXnnWac9QCm81c6gLmpg28/wQcZ7a33V4aeirLX7oaIG?=
 =?us-ascii?Q?oxViD0LAA0EgCGgc+7Lrs+CcR3PelchJebB5vnqAYjTlxTubssy0vN89KJr5?=
 =?us-ascii?Q?5EgOBAvDj3WhmtuO0vSmsaOG97rxKpAL2qVSbnB6OmQmVvUlw3d2vPukpVHK?=
 =?us-ascii?Q?pdHIyGW0M89dFwmfcRJUInTarrFufcObwdmkffi+BfPlQqcitweY4WYnQeDe?=
 =?us-ascii?Q?619NFfR+vUNHniJxiwraN8hkT9AYhflDfQWh4k9SK11N50XV23ijE/5yf/U/?=
 =?us-ascii?Q?5VZytIt19Q8NGgl3N0losCTedO3G591GYchL5VM0Pwg1wQWBX+N6j3uEIoPd?=
 =?us-ascii?Q?8YEjU6Un8P5wT594JxQ69X2NrceNmAWDgXiQw5uvRNn4KoBF92Plmik7Xk34?=
 =?us-ascii?Q?5VM41QwvLDLet52TetuTh0VBZ1lfkwH4GYO77dhYCVijDqslDiYqwMzyjT/v?=
 =?us-ascii?Q?54yS6xDfAOvje4/GZ8Iij2ui?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05e6cee7-d18c-416a-a0a9-08d96201ad60
X-MS-Exchange-CrossTenant-AuthSource: SG2PR02MB4108.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2021 04:35:59.5104 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /9pcjF0kclPP51OpC/4U77Nmhp0wqAFrB+3OKrPN8r2dJiP2IeG8p/Ttojisggmnfll0wEPXZT27F/GJhC1q/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR02MB3943
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
From: Huang Jianan via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Huang Jianan <huangjianan@oppo.com>
Cc: yh@oppo.com, kevin.liw@oppo.com, guoweichao@oppo.com, guanyuewei@oppo.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

---
 .gitignore | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/.gitignore b/.gitignore
index 8bdd505..0e54836 100644
--- a/.gitignore
+++ b/.gitignore
@@ -27,4 +27,5 @@ configure.scan
 libtool
 stamp-h
 stamp-h1
-
+mkfs.erofs
+erofsfuse
-- 
2.25.1

