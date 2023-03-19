Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 802EC6C0056
	for <lists+linux-erofs@lfdr.de>; Sun, 19 Mar 2023 10:27:44 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PfXb22tgTz3c6f
	for <lists+linux-erofs@lfdr.de>; Sun, 19 Mar 2023 20:27:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=vivo.com header.i=@vivo.com header.a=rsa-sha256 header.s=selector2 header.b=ndoem+tg;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=vivo.com (client-ip=2a01:111:f403:704b::707; helo=apc01-tyz-obe.outbound.protection.outlook.com; envelope-from=frank.li@vivo.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=vivo.com header.i=@vivo.com header.a=rsa-sha256 header.s=selector2 header.b=ndoem+tg;
	dkim-atps=neutral
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on20707.outbound.protection.outlook.com [IPv6:2a01:111:f403:704b::707])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PfXZv0RSkz2xCd
	for <linux-erofs@lists.ozlabs.org>; Sun, 19 Mar 2023 20:27:31 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iqb29GcTJUCysI3rcc56fROhsQqwffcvKMdIDBe/zgKr8ZeyJtNaNq/H1ckyaIRF0pwuHI1JlJAYrxfxvu16/lCh+rX8o/iPweTtLld5eXquLsenWUZBfasxgSlnUPHxGtfPCU0WIT7W9+hMar1+r540HprcSisUQK2DK+02qQFNwnQjE4IXfM5Z3O/RVD9TrkS/HYeTlczzPcJawJSnigMa2HjK6KmnWKeSyZQwRm/P8wZMin/UN/L4aJPFUejU95BWvUUrrpYWzBuFwL+rmIo9wAZPdZjklscnUvVsvhQGAkpnBPXpgNIe+C8019ZlCS5PY1lgYKmK37U8s7wLzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9dAsbB8HLSyPKnYY6MgLGkjsu4SEDUT5dyHTJRxvePE=;
 b=cf8JflYD6uGzPLfwQyJW5FjKkdnd3GKy7/Vu7dABJ6ioBjeirFpOosYPnoh3EaM7EhT58eGsPjIRJpSsYomDo1yiHrSZZkjWS6tujndHNfQ9Htu1PgiYjWJ5pRpFKF8R+RiFwthBVcFD6oRnF70IjfsYKpIy/li/IkwDBJLvnLKaSr+9Uftpuge3GXV/qYxFMNI4NLIIf9FsxU0CKVM3lYU0vMNZJpt2ZfjYXa+kLIZwwgwNBxPZbcM4PLjT5V1XZ0cpz4f9uUf+i2XauxqKdKs8xAjEvLqUopNN6kiWRDnEEVoTs/zUj5e5f+oLJqNGHc7DBLs7G/4ReJifGZNRlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9dAsbB8HLSyPKnYY6MgLGkjsu4SEDUT5dyHTJRxvePE=;
 b=ndoem+tg/oWKncsuhUBUc3B5gQwH4GXTS5vZKsFkwA3c1scUzkE8f1SSGGRbrRDv4lN4iBlQbgT6/j949spT4ALD7EmQn6o3VLUCMXAaCLQVoY8bAfSEykdarwRb4WX88o8WFlalhntbMGfPCmFh2ypdF+2j8b5B7qFhZdeVE8Wku/CJcR9cdxDrYA0IFN3IS3/F7n59fpPB3/+rtBB7OcK8A8W+nrICvP91ilYysxKsRGnQimUP1DRFnxaiX8OjvuRX7kZP3DeU5yDy3K3cs3T4bL6oz4Me9z+RCJlrhXwy7hQ2lnZ5247ip0k1O0pDVEHfvtPod9WW1OS2cAvlMg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SI2PR06MB4012.apcprd06.prod.outlook.com (2603:1096:4:f9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Sun, 19 Mar
 2023 09:27:12 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::daf6:5ebb:a93f:1869]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::daf6:5ebb:a93f:1869%9]) with mapi id 15.20.6178.037; Sun, 19 Mar 2023
 09:27:12 +0000
From: Yangtao Li <frank.li@vivo.com>
To: Gao Xiang <xiang@kernel.org>,
	Chao Yu <chao@kernel.org>,
	Yue Hu <huyue2@coolpad.com>,
	Jeffle Xu <jefflexu@linux.alibaba.com>
Subject: [PATCH v2, RESEND 03/10] erofs: convert to kobject_del_and_put()
Date: Sun, 19 Mar 2023 17:26:34 +0800
Message-Id: <20230319092641.41917-3-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230319092641.41917-1-frank.li@vivo.com>
References: <20230319092641.41917-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0137.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::17) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SI2PR06MB4012:EE_
X-MS-Office365-Filtering-Correlation-Id: b88627e4-a901-41de-49e6-08db285c1ec0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	NEdw4AT/k2AEYFpvs5hWUA1/YseXLkRHC23/iahN1X3hdFxVyXlSKzxEP9gW/dsLGRwJwRSP1YPbiV7JDVroTBOgaKQG6qbclRUcUEIBSITBEYH86/pMm17P1r9FwgwBMnGHvd+n9eQ0QsRwhkrZ5sa7BDqphpWCaVqbirApjPov/JQtM0gGOyp0CaRUjiFztkBNaT5IERFprttZ+iYdGSSiDlt7Z5i3Afj+DmsGmeufmrWADiDVrUMNSxeZiLW8dfWJ42E9pzBzZPA+Y9JFUBk2aZkIqAOhmtfhgTUwBcHYnEhox/c6cj6wb9lc787G9x1I0l2YXBfvJkKaPDR3Gc+YrORnt9XWyBkquTikd5r3twfDX9wa2ceBoYKbriJN3Q0KYvwy3Eg2N6bZaaRp+OqgcOMD7KQoHlsa6JMS7Ad1JxnE6O0UCtzLKxtiSs6NReSAe0DlbrZ7IynMgGeMJIt0MMwUuiV85kW7R2Z/z8vHWV02Th73LbQ2u/Pb86F+COEJnYSQCGue89e+jCPk45K6cMuVR/dA9N5w+xcjo+wBKlzL1P1pdi3gQasCMqY4d/WwRCWDq4rtIF/8fCUSibwAYsXeQr9uyDbpxqwr0wpdJU/z/xi2AGECJDnD4V/bZF/crxAaDfgYnehqDVajuqMK0SEvMlb0fddlc6fpPgFPm+R/BuOWHdM9rOpnVLJ9+FjAS0ownm52mdKKS3XjSA==
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(346002)(136003)(366004)(396003)(39850400004)(451199018)(52116002)(2616005)(478600001)(6486002)(83380400001)(6666004)(316002)(54906003)(8676002)(66476007)(66556008)(66946007)(186003)(26005)(6506007)(6512007)(110136005)(1076003)(4326008)(5660300002)(41300700001)(4744005)(8936002)(38350700002)(38100700002)(2906002)(36756003)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?us-ascii?Q?amW+U2SyqghkRmvcE1MTAi7HQX5Ao4c05kkoAcZJOP/nq/jr5edwEFt/sIAy?=
 =?us-ascii?Q?uWCkwoSe6yn63gb3VXVumCZ4pvD0EAFk//yrSJn1D5hNqyQLn+fYEo1hLW0a?=
 =?us-ascii?Q?sgTPVDWKw+Jbo6CXk5bcDRrhYcs1gymth7ZtaCkMWSLpZ8cVPkT0W/l/G5Gg?=
 =?us-ascii?Q?WbJ6DKB3wr9iSF7VW8vzOAldPnZyiTCc9/TsUCX1znMWtOvuu+aQ4sHPgA7L?=
 =?us-ascii?Q?gCLcCQFMcmXOOPmmf74XiT3saKE5mDK0dlnMXALHJbIBPvFvD5iajueRKIRk?=
 =?us-ascii?Q?URoRV+OZk8ZidUBkrMM7L+pxyAYhPZRluqk9C3eSvl3ecevLxBAxqquLzhtM?=
 =?us-ascii?Q?BUGKkcaSOw4L/fQ1v8wjuSg3+K80DMigeRIv33ztDjxK/g268gd5x8PEmFdh?=
 =?us-ascii?Q?RP/3F7Y4levILou9UPQQ6gy0lPrrETD6/pbUgPCY4m/nfZ7T+SMuo1S+IUm9?=
 =?us-ascii?Q?YdQBFq4aiYOZ8kBn6vbbjf2NcLe34uK2+tSE6gaueDz6KugqoqT1HrZYTNCD?=
 =?us-ascii?Q?YzkUO1fPUHkOHyzPfGkq+zEwgNJyP78r8CYudQ0qcL0FPcL/ngqgVFQr9DFn?=
 =?us-ascii?Q?oTrWag3ZHhIejp34kOqyqnScjgc3SYRWsu14lBhdetYy306DyrMlGeLLi1df?=
 =?us-ascii?Q?a8erXL5r54y5MMkNW37i8vO0ixev7AT6B17tXXBVw7sLp4BWItBg8GGbdHpx?=
 =?us-ascii?Q?bucukj8fresPtV8CjbJ/S21y5MQIaUP0SOK8Aurlmrw/cSRQADeQgLA3+Skp?=
 =?us-ascii?Q?QqufH2CPuafRj4zkFOEoIXwb/aCiyqnfoVphcxnUr52JEL1D3DYrhu6DIiE3?=
 =?us-ascii?Q?bJVvoe0ZCoLwSgVDSiijxQkCJ/VT9ZNrDl3jWc9ox8cI2yek7qKuJARbiBAa?=
 =?us-ascii?Q?8WG2FRTwy8COyvm4O9fd58L894g33qkma19kmBwfuoI+HwhmjH3c3+G/cXoo?=
 =?us-ascii?Q?l3fSjBmEWEEwdldM5BGO6d/iRQl1CnVA6ShQETF4EsACmcxxQkpnn78stCbG?=
 =?us-ascii?Q?ID4K8J6ZBDAS4bKa8RCI+eyOIo/Gf1KTLtYNbWBTzVGpcAmtz9peyvKUj7E1?=
 =?us-ascii?Q?BCVzE+2xlS7LVRi6alpoltD/NJ98mqBeOGKItVDh3eNPEtNnRNL77V5sng/N?=
 =?us-ascii?Q?AtKuBr8GjKSHBj8chV1Sjaa5bX8kRrc5O+gKZ+UFmxtHjI+oGt5/uC4xaObX?=
 =?us-ascii?Q?sDymegD1rtgXpuwpIBaSVNfjlhxDH4wFlYIlFXg/dRxvaxbpIl568ao1fHSs?=
 =?us-ascii?Q?SWso+RA2NfmyCpuKqmR97yN8yAAtjjem8EauN4vqrMab+ZTNb7AwdhQ+mpMO?=
 =?us-ascii?Q?N8HYG5pG+5U75CMNChFE80yEx05p5SbOu/z/6halwGmu9vur5vKhTBaOBTex?=
 =?us-ascii?Q?YCMJB4J2J5OCnc7txWuSUJ5FhKH79pLM10/29vgekSzVMY7PaJKiwrNRJe6S?=
 =?us-ascii?Q?kBUJzLjWYTkUOH8Wj8puiUOupCgYedDkG+AUzP420Y9dTu4pHLLS2U6Df/pa?=
 =?us-ascii?Q?PsaOKPr2n0hc1cFoadqdQkZp+BYALO9jaGFyxgH/Wb7C0cedzfMfDdbyObc5?=
 =?us-ascii?Q?VGmG5dM5rSeeoJCGwX9jUCbPLlRpbw3r+xxITk61?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b88627e4-a901-41de-49e6-08db285c1ec0
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2023 09:27:12.2639
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YY4SLmt5Nn1EF6M2J2KmGbdU2eL8QGPabrAGWupoO+ITX7pempAPu+bAN81NB/wD5Ht3mUELYv1rDCPka/87lg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB4012
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
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org, Yangtao Li <frank.li@vivo.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Use kobject_del_and_put() to simplify code.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 fs/erofs/sysfs.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/erofs/sysfs.c b/fs/erofs/sysfs.c
index 435e515c0792..9ed7d6552155 100644
--- a/fs/erofs/sysfs.c
+++ b/fs/erofs/sysfs.c
@@ -241,8 +241,7 @@ void erofs_unregister_sysfs(struct super_block *sb)
 	struct erofs_sb_info *sbi = EROFS_SB(sb);
 
 	if (sbi->s_kobj.state_in_sysfs) {
-		kobject_del(&sbi->s_kobj);
-		kobject_put(&sbi->s_kobj);
+		kobject_del_and_put(&sbi->s_kobj);
 		wait_for_completion(&sbi->s_kobj_unregister);
 	}
 }
-- 
2.35.1

