Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id EF1AC821D7A
	for <lists+linux-erofs@lfdr.de>; Tue,  2 Jan 2024 15:16:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1704204998;
	bh=3Swq37uhAWUQ5Zj7MMbNjwGJ9NDTVdOAgbnF4YM/foE=;
	h=To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=fuVVepyMZcsSrlgZm0Zl24hkUJrYOjyrati4U0T4j0Hw5xIrm3Skf1dvBihDCL29h
	 IKrbDxiLRQfzXO0wAcgNNiP5L4ISbZwfXY7Bf/3G2LcA8t+mROSZAnQ5Mg/qQM1Ag2
	 PN+zHLBuRPE2BCmuHK/7yxK8xR+T6BWVshonioz99TIhEPako9/2CJ18EsuSI2QBxk
	 UO4C8m5WD2M5U4xAEvpT3VeO37k9Lo/WIvogyrKL+5MuNY1XWSXs5zTiiUveZPFRIB
	 /jKx0EedTRNFOB8PDk9h0SPrIKkZue3RhpDJKktDJB6wazFL+haMddeUaA7eiBEIJT
	 0q9IrZNJk5xUA==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4T4FK20btzz3bn6
	for <lists+linux-erofs@lfdr.de>; Wed,  3 Jan 2024 01:16:38 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=vivo.com header.i=@vivo.com header.a=rsa-sha256 header.s=selector2 header.b=NecJOlmM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=vivo.com (client-ip=2a01:111:f403:2011::701; helo=apc01-tyz-obe.outbound.protection.outlook.com; envelope-from=guochunhai@vivo.com; receiver=lists.ozlabs.org)
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on20701.outbound.protection.outlook.com [IPv6:2a01:111:f403:2011::701])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4T4FJs2mYNz30fm
	for <linux-erofs@lists.ozlabs.org>; Wed,  3 Jan 2024 01:16:27 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jIG1ebo8HOWkg9zT8v52qP6gLGyzqKuVMsmVVbLCn6yTzZmjVNiDGxS/IKY+7lJurKjP98HP8WEYZk6Tx4lRTuVtyw1eQB2TnUjKNahWJT6FWkbbbFy4F1zuXXVJDcTF2ZQryMOBcnh/iBJ6JTDGo7OWiBh1yiN0a3hfyt5cIL2+Duv67kS8NASkoNczyBhfVQfQcNuOxnu47C4m6thdj8zRsEebbW3Yv+LOQHKqXzwDd5hrvKr+rk+tvJfSUSBTyQ4y9uk/fTk8ApHLkEZp5pgt+zuLAm5LHj4BUF+y+sDk4YWRqnW4ijZFSxM5UgJKhdJ8t76jkJwb3ytP7SUdMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Swq37uhAWUQ5Zj7MMbNjwGJ9NDTVdOAgbnF4YM/foE=;
 b=gVAn3rYON4pOvEvXQnHhRr7HlC2vc06wmNlb3VAuuDwq1063HfLjU6Str60j5UoIG1VCAKhgt68ByqSMzR8Aj5d21+OX/dm7742w3gVVF/TfyyWv5dNvNi0NWXEmTQBvu/hmG/lAwk+DK++r5K/0/ENgzkF0rQBqHUYUF2L9sFLXy2PfGsixDvOubIkHH+mhuzJwNmMHfv6CaM9rNv80GUqUYb+UiVFmQj2QlWGUJBvajGEGJN15sE+x7wkOt+jVLyAuqGNwCUDmQjHecOs2yzx8nuoRxNMNzra57y7FoCD8wYCEYQ4iDbRpsKDtin43SI3kSQEvbtBIadNOthOrBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TY2PR06MB3342.apcprd06.prod.outlook.com (2603:1096:404:fb::23)
 by KL1PR06MB6396.apcprd06.prod.outlook.com (2603:1096:820:e1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Tue, 2 Jan
 2024 14:16:03 +0000
Received: from TY2PR06MB3342.apcprd06.prod.outlook.com
 ([fe80::b403:721d:ec13:d457]) by TY2PR06MB3342.apcprd06.prod.outlook.com
 ([fe80::b403:721d:ec13:d457%5]) with mapi id 15.20.7135.023; Tue, 2 Jan 2024
 14:16:03 +0000
To: xiang@kernel.org
Subject: [PATCH] erofs: make erofs_err() support NULL sb parameter
Date: Tue,  2 Jan 2024 07:25:32 -0700
Message-Id: <20240102142532.2874542-1-guochunhai@vivo.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0198.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::7) To TY2PR06MB3342.apcprd06.prod.outlook.com
 (2603:1096:404:fb::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY2PR06MB3342:EE_|KL1PR06MB6396:EE_
X-MS-Office365-Filtering-Correlation-Id: 876e177c-35a7-49b4-d9de-08dc0b9d5a0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	vJZFrIqPLsGeuZZPO1IZiLBMTLPVkU3Wa50gwiA5HlmlnXwyQ7aXxuhAeYMkpzUT5z+AF9E9QvHcjMTF/nFxYOvbR/15GdO9Q/5zEwIgXsknrrg+dNWFpO+nxt1CBtGF8VWt0JYo7t35mNb0qi1TUW6VEzfeGCPdtESbM1K52qC60cpYhrY8R0P1tf478Twkt4aoMpkhCTnLUjLCaFXHc4+NMJJRvWoRB4csmjXKgwDDDSsvrtU6SoDdDPbKD5QxCz18P82kKd+lv8qfISLfqjA1BCpa4CXUjwAH6y2VheMzBMN/zKbt4/cMBzgeUTVSa4UrR2aWlvAyBQpCQ0TbSwzUNAc62w0vYSVku5QZkshMJXGTauaz9KPK9XWcgtTbbARX43NKjSfJE4AD8FUXWypUorwbwIekgf1B6395YqBf+g1dLLSOSWAuD9lCqsDxideo3SjauJVeeAii/dWyKMq/lnZe4m6/m2yPT0ascDPVlIEnMo0Dc3RPQFevGud+0w7X30dWHgmiZxd8kojUcXLAM3VoLVv0lZaEmMFl9h9hk0g79bZpQjBMDPMGDpdKgyjt23ohVXyCKTyHQE7NO20OK9Jg4UOecOPMsNXwhIcgTzFDumit+HaItPTdkz9M
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR06MB3342.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(346002)(39860400002)(376002)(366004)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(83380400001)(2616005)(107886003)(26005)(1076003)(4744005)(38100700002)(41300700001)(8936002)(8676002)(316002)(4326008)(5660300002)(2906002)(6666004)(478600001)(6506007)(6512007)(52116002)(66556008)(66946007)(6916009)(6486002)(66476007)(38350700005)(86362001)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?us-ascii?Q?cmmRXN3TvFhghBqulFJl2BWBE2DNCC6EGOoBwRjB8wn7hchTOD/zwI53weXF?=
 =?us-ascii?Q?dNQcmXC3iJlukmr6Ga8+7kCtgM3O+DDF0BzluDho7V0JRnY+TVJp3FFhhqyH?=
 =?us-ascii?Q?VDuRz+pOqOzdbkf36iNLoEqbO8llZOS2AW1xbRo2mZeFYKBshxNdHmTXtBKG?=
 =?us-ascii?Q?Dkb4/NpTCAhgwF/sge+iniXkg0nPmonjuJA6nbY7/qxrgusk5wV2q/Eu3ies?=
 =?us-ascii?Q?tGoJjjOYlPQd5Tu9gCWbalEYxxn7bs43xa3dgq9WHm5WdITjzXfRmZc0idX7?=
 =?us-ascii?Q?wwE/ybAJBaPx3kIldB7jyh/Sxs9dxjQHIBygjA+R6LzhBsSbKqdPm0fkI0P9?=
 =?us-ascii?Q?hvTBnvxFJ52Mb7+K2/oqxo1kWfVzln93OBNDb+/FgrxD42an087y1LJAz7od?=
 =?us-ascii?Q?LgKEzJcbWKZVN1uUtNZOdzch8TdAvOf7I6tHJ0By/mv7vd3xHviIlodzWF2W?=
 =?us-ascii?Q?E4ljOFSTpjFNfslc4j9wR0Y7TzcJ1FLIgNZslIV5AgyN6TGInc6ko8Puu91w?=
 =?us-ascii?Q?c+ykMWyL4tZUtMRCjnUV4Q7ew2eFjAboVXCJvy3AwFE+40/mHNANxY2KWsx/?=
 =?us-ascii?Q?W5ChZlZA2sX2NixUEbpGpP/3mX8adpZCs/oUHBd+hSFBWisWdA4rRjWaAfeB?=
 =?us-ascii?Q?QyHDd0SyA4CYtPAbvSYiFftFzyIoDqHl74RDE6ocBfG2ZNw574t85HM3mhlb?=
 =?us-ascii?Q?8Hou9MvJCr+/+ADOGXmhvT8Z6GeOWE54PswDLCbh94QytJrUSYzqK6r56drK?=
 =?us-ascii?Q?gRowPVjR6G4qvufYA3Ve55YwVGUkfKE07q9B/35AarRONoKb0k8WwV91xsmU?=
 =?us-ascii?Q?OZtJPcV+sEkxo1d7EzeHLKnAI8dbRPs2DgO3XG/bwZuZmacFKCRGP/GJrye/?=
 =?us-ascii?Q?e6ruWu6wGTkQq2bEx25mDGW3YQzONAzDvNYgEHaSGRm0B9EWlwGF9NADQ9fA?=
 =?us-ascii?Q?1+EGtPFxrHoU2OB11iXiCbChcwWPhl8E+JNaW/yOXt+IFd19o+ScLhsRuYA6?=
 =?us-ascii?Q?KD7oOyFwwAvRpMYSbGn9GYKfP+HHZnHJ7JDJGKjtI3GPXPsccSX4hpbR5JRt?=
 =?us-ascii?Q?1GjCpzniSO0MCJcmyJ4sCJmslpqRFkKmp1gfl24k+y2kAMTZWp1bk8r7EeX1?=
 =?us-ascii?Q?fw+ND9JNRr0P+k5yyEKffGdohR5w43ovQDR1QQ/LpGWYK2BPHDI3TEFartsv?=
 =?us-ascii?Q?doH2iRKhAdYTxWYUWpHduv0dOB9pZqq6GPqT4fpKOPA+UaS20VIhUS+gJRCO?=
 =?us-ascii?Q?BtltVPgCU3IFVwTD3bkdgvySdygos7MREgLuFC5rgFTN+hl3GEyuZDH31oOg?=
 =?us-ascii?Q?sY/vjGUih7KtX1fPwqt+/9AqQg/7JtpPlrL2Dizkc4mL726Jblew1czNSh3O?=
 =?us-ascii?Q?r3c1UAx1AhRKB0vqFNAjTywfIA40UZDdOCPw/Z48JPTlcqO/1rGcHLCqD8nc?=
 =?us-ascii?Q?bDD4fJHoqeSwGUY4IuEekgDuuvd/A/7RC5j6uk4yet54QB/DHWzYEOTPu+BQ?=
 =?us-ascii?Q?SrGnR+0jukkFGdfdgbtdjk8ae/W1fnwlp+kM8UptQxjRMLPU2qMdbqJUTReP?=
 =?us-ascii?Q?HCwat2oMVESgt552/6RTrVTo3TvvePx8sBYY3cjP?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 876e177c-35a7-49b4-d9de-08dc0b9d5a0f
X-MS-Exchange-CrossTenant-AuthSource: TY2PR06MB3342.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2024 14:16:03.1610
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4VOOyFbc5ht5a/1p2/vTxXg7sOCzJNCSE1CmzNAo7Sm+5iUF7Ow13nrHRbjGG0spks9ENkYJ4fjfmWcN8EHdOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6396
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
Cc: Chunhai Guo <guochunhai@vivo.com>, linux-erofs@lists.ozlabs.org, huyue2@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Make erofs_err() support NULL sb parameter for more general usage.

Suggested-by: Gao Xiang <xiang@kernel.org>
Signed-off-by: Chunhai Guo <guochunhai@vivo.com>
---
 fs/erofs/super.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 3789d6224513..f20dcfacdcc5 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -27,7 +27,11 @@ void _erofs_err(struct super_block *sb, const char *func, const char *fmt, ...)
 	vaf.fmt = fmt;
 	vaf.va = &args;
 
-	pr_err("(device %s): %s: %pV", sb->s_id, func, &vaf);
+	if (sb)
+		pr_err("(device %s): %s: %pV", sb->s_id, func, &vaf);
+	else
+		pr_err("%s: %pV", func, &vaf);
+
 	va_end(args);
 }
 
-- 
2.25.1

