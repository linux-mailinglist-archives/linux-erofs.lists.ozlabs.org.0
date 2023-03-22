Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D32C6C5173
	for <lists+linux-erofs@lfdr.de>; Wed, 22 Mar 2023 17:59:59 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PhZTR6nMHz3cNN
	for <lists+linux-erofs@lfdr.de>; Thu, 23 Mar 2023 03:59:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=vivo.com header.i=@vivo.com header.a=rsa-sha256 header.s=selector2 header.b=HVVPnH7y;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=vivo.com (client-ip=2a01:111:f400:feab::71e; helo=apc01-sg2-obe.outbound.protection.outlook.com; envelope-from=frank.li@vivo.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=vivo.com header.i=@vivo.com header.a=rsa-sha256 header.s=selector2 header.b=HVVPnH7y;
	dkim-atps=neutral
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2071e.outbound.protection.outlook.com [IPv6:2a01:111:f400:feab::71e])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PhZTN2hYBz2xWc
	for <linux-erofs@lists.ozlabs.org>; Thu, 23 Mar 2023 03:59:51 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cWIMsgH/aGCG5e9bEXCJ6cvR6R47MEPVzFH+c41MxgvdhsicsqpxT3nFbCoXuYJd/W5hSC4yILjeID7St8qEyKD6iuDmYlc7gkGE069AUkLeupUDrxhl9eYdJuVcG8g3bzd4jIjHvs1jnWiPpmMEmInqUybo9gu8g5ba+YoRyHMueIPyVbb+vJO8dpfVfWiiAM75/m4D+eTNsSvGP05Nih35m/CDHh359fBujI8lXg8oJW4i9Xpygapklh9zpRbQZPNwgo9Caz9NXyAZ+mFJZvioXtVlxGiSeNd7hhbgAKMQeGrnD428cn6QEAxW7dKgYKxVvKVl2+Y8SOtMgPi46w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gi/SB7uU/Vm7xG+VaANHu7liHPdOo0JIwPJ5priBNiQ=;
 b=L2t4AhjOdoKEiuApLGF9LCio3OSWfV88LssMYhpL00xf63P9v4dIADiEL7zE6mru/oJNJ+nrUPpzUL4GB+lm1a3cO97Qy8Yl0x/SjamSksG507hYToYcBJUdOEedQIta0n3zWB5dDLv30e+9CYbghFYZrPDZkd/hxnETkuzk5a0JK1+PIwI64ingHF4DJSo0c4fdCQoOjvS0ykWcL55hkSqZy9EBtrX2ATMnRpcQDjqJig8HO4Y/8/Iw19bqNWmHVRBCOvm4JZ+FOk9zKX0xokpyJmggSTVv9afqxIdKoGgOUJXIp91dgaAWdnDJfL0kHsutZZOEiBgtVXKqaPCR1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gi/SB7uU/Vm7xG+VaANHu7liHPdOo0JIwPJ5priBNiQ=;
 b=HVVPnH7yU1fLqUyEUsCqiSbJbTkHQV/Tumis4/OgV+ID8z0ETAMxmb5SSSuG8su9SW5GZg9T/dhqbYUu2RQNkWZuUqlRz5433oIpXHiNgywM6YN/E2WHynGP21CvsAB/oKIgNPpe/+DhBzwnuBOCgvF05nwf+SmqVhLb4C5wYEuUZz7i3wBFdrXPbEFSBsd+85bM4K/lWhZhfUFdUt3wypoOPVjnaea/18ntRw7iE7+AWs7n9sjyHa3BAkh7XlecC+1iofwdeqvfsJN+tbSDnSQp8cRrNOCgwTq083x1OjULMyxNruiGSGgnTd5yK/JcIyUhehmSPbE1xgQ5WlBFZQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SG2PR06MB5238.apcprd06.prod.outlook.com (2603:1096:4:1d8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Wed, 22 Mar
 2023 16:59:34 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::daf6:5ebb:a93f:1869]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::daf6:5ebb:a93f:1869%9]) with mapi id 15.20.6178.037; Wed, 22 Mar 2023
 16:59:34 +0000
From: Yangtao Li <frank.li@vivo.com>
To: Gao Xiang <xiang@kernel.org>,
	Chao Yu <chao@kernel.org>,
	Yue Hu <huyue2@coolpad.com>,
	Jeffle Xu <jefflexu@linux.alibaba.com>
Subject: [PATCH v3 03/10] erofs: convert to kobject_del_and_put()
Date: Thu, 23 Mar 2023 00:58:58 +0800
Message-Id: <20230322165905.55389-2-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230322165905.55389-1-frank.li@vivo.com>
References: <20230322165905.55389-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0012.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::8) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SG2PR06MB5238:EE_
X-MS-Office365-Filtering-Correlation-Id: d89c2428-7efe-4647-4dbc-08db2af6cfd7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	ja/Md3+4XLTascUojIsAaH/+vXNfWIetuvfwOmkzlURwjrymUGX4zXbUz9qT8+TudtumEuvALlbIZ9s0zknm4jX0WnEJnTRnSdDt/SZM3J2+kkTk11x0bPJKLI3rVvNj1hvZvwK2aEN17OxZkpynL8Wmoy3QKRDYxX2uZodPHP//Qr0fuqcLN9GYuIiguP602AiAZXu3i9z0UCmBk5mfqHebyhI53SraXDMkX6B2BInZAEYo02CleBkPo7WjvFEI9u/eMmdUzfMF+JNSLuoc6AP8aIaIDwVM/yZiP6++NTEBobFPvkfEBLVNkaU0if6rWjV5ou8RKXXvjxGerSVzltqU78Ro9ahvq/wcvLOTv8KHGxS/jdJp1C89fnFlMHR1cEpoBzzYnE34W25JCPBfA9DUo6jw6skPj3X4L1emtX3rTQMPJBGg3sHQ78jSAlRadUeuYmdCuZ+1a4E3ZYp8eIbFsQqpShVFuRHcx5z4NbH2EedgxfAJ8Xgi5advVocC1MQ4MUS3C4wwxOherqzFNOfnTOyblNMX+TrR4+l8mbPQb8RFMG5Om8YYv+mVARTGGutng5tC25jgjuT2/qLm/YNcYXws9mG2hAloZC/4MU8qvZW/K+AxJh23gK7wgh6E1KktXjEKCFXSrav9o5u1SxprfBRMEFiNMnaNgWPbtJ1su2nXEcfgvqGXDhNRotL4sIxLsBSj/IZzu7MASujT1g==
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(136003)(346002)(396003)(366004)(376002)(451199018)(2616005)(6506007)(52116002)(478600001)(6486002)(6666004)(83380400001)(110136005)(316002)(66476007)(66946007)(66556008)(6512007)(26005)(186003)(8676002)(54906003)(4326008)(1076003)(8936002)(4744005)(41300700001)(5660300002)(2906002)(38100700002)(38350700002)(36756003)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?us-ascii?Q?6PMzENuswHEjU5t/l9xsPxxaa868TJMzYdajTv1mTyVu9UxS1ukDTLkyL6Ov?=
 =?us-ascii?Q?YTSQcMrwmTifM/mcpf8pkuNBmHIsRuQXG4bNmBK7yiZVu0h9wnMw6q9j22OZ?=
 =?us-ascii?Q?wXI1VMJ214DtxtibCrd9GRzRNiTSOYcJdPF1eI7OmGGPQW1ZlFD8l88DebS6?=
 =?us-ascii?Q?RPSB+dj3yZ4tXzCNHeRh64fkwSClZkHI3WdLxXS98CrXQsHLhKnTw+HAgrsj?=
 =?us-ascii?Q?S95NFKugAzK9knQTGpZpKQEAcybzV0VvUHA9x5bdpZVtgyDnjDkNYyqm8BFO?=
 =?us-ascii?Q?oSrSsWhkSVDH6a29+ucJQah1EG4iidgCiSRj6aZClbWd19kELTwZa1xH7yvL?=
 =?us-ascii?Q?WRbQ97q3/u8OysJ8UPCOKISPhQt+q4LNqSQQWXEvkpS1UuattIEUxxmn7AJr?=
 =?us-ascii?Q?2WLRpf29d86lB9X4rsAtFVnJv5L/dEUl9EUbq7VrFbnGHa1+ITQmf8tXJDes?=
 =?us-ascii?Q?PsqZ0SRYHht4X9F0zST3pSqxTojyJf28InPJc3uNXvcYrcUS/hOLJxAxjKSg?=
 =?us-ascii?Q?ET6AcvDSoMhRDH3X6oHrt4SfmNoC26uBv3SvS2u1C+hTEl2hr9ohSz1yTcOg?=
 =?us-ascii?Q?2JBiAzWqousTzDAbxy7Ey787iFeNu7GprzouGwce/atPjQ2yZ78JxVRNTqBo?=
 =?us-ascii?Q?1LgquwCWL6Qdcxfc7X+z8OWSfCMyhKGVOn5TFiVUTjMXoBX7pC308IJ+7tte?=
 =?us-ascii?Q?G/kka8K3u89KTxI3j+JeNeU2B32bKi8emqgIvw5pn7KjRLY0CeoxaQOmj6Dd?=
 =?us-ascii?Q?wE4LlA8l2IxSznDa45BDMGJErSVLW2DsIvLwlKsreoavqEm3VhpKACMP4Irw?=
 =?us-ascii?Q?Qj8MWPD/FoFopgeVSiIQI0MxFgl6wfCKaMNGW6NzamYcKsDaLRfvcAfsKrQH?=
 =?us-ascii?Q?ly4MO43SWA+GJE3va5pk40mi4VlK5r3lrJfvkQyc8YtUsV72JjCWtn3Deddx?=
 =?us-ascii?Q?tDvLD3cUEE68UGUWJ+TndQoX9eBo9bDE3uyv/ABGd0mvLZMTT2GN00OsJpMi?=
 =?us-ascii?Q?CK9NYOdP0gqPS6XMZmgCSCTrcIAIgu5p0ZVOJpIjF3XmGUYQ5evk/V5d5BZf?=
 =?us-ascii?Q?iAOm2+xVOb29T6OQCwKcM5aJWWncFiNvn/fxOse3JYQ7CRjDeTMO/9v0YpCW?=
 =?us-ascii?Q?7MBebbicZEe5WfyaUR2yIsnJc+wc2p+q5EtokHMQaUhuDCXtf5uu/YLyN2Xk?=
 =?us-ascii?Q?EQVwJ18H0dnIUw/MT7LJ3D9dm8qOHIfJI413qbYMtyU8ctoCZha8JmLQ6YNh?=
 =?us-ascii?Q?rvh76GXnWGY0/3PtHX/Y0WYM/RUgNvT9sIjfftVvrM6ift2AuOC1uJJ0+OdL?=
 =?us-ascii?Q?COjjz35nUxE2EWtq5d1jZD987IRWxZAshGNRq6PajRSJyTvhpWWyAUdkda+u?=
 =?us-ascii?Q?a11cWGzEauJkarv4UEAPa0C0Qtrb1hf2GXI1bsP7dYmzDJXSC5ivmAv8jYN+?=
 =?us-ascii?Q?nW0yIfxSmDHHSR8rUeH/8hwTv7/FmHYcl4l4pX1iXiK7tcNRfzfppPNVJPMq?=
 =?us-ascii?Q?ETLOUuaCN+TSg5qiE3KpR1FtJLqqnP75rvyts3wT5ox8RIaI8mlJzgEbilSS?=
 =?us-ascii?Q?0u5v58yXAX2kUIrfTCemSuWHWGn8QF2g3lj4bJTN?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d89c2428-7efe-4647-4dbc-08db2af6cfd7
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2023 16:59:34.3509
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lz9ovNjaymPachLyjewdT90IjkHX77kfsey2EeFVRaqO9xKiu9vVgTrtVywED52BPulRWHfo+RoamMWxeD4w4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB5238
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
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Damien Le Moal <damien.lemoal@opensource.wdc.com>, Yangtao Li <frank.li@vivo.com>, linux-kernel@vger.kernel.org, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Use kobject_del_and_put() to simplify code.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
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

