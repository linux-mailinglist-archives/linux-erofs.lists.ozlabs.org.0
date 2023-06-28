Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 46E0D740D06
	for <lists+linux-erofs@lfdr.de>; Wed, 28 Jun 2023 11:35:54 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=vivo.com header.i=@vivo.com header.a=rsa-sha256 header.s=selector2 header.b=L6AZ07aa;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Qrbzr12G3z30PW
	for <lists+linux-erofs@lfdr.de>; Wed, 28 Jun 2023 19:35:52 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=vivo.com header.i=@vivo.com header.a=rsa-sha256 header.s=selector2 header.b=L6AZ07aa;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=vivo.com (client-ip=2a01:111:f400:feab::716; helo=apc01-sg2-obe.outbound.protection.outlook.com; envelope-from=frank.li@vivo.com; receiver=lists.ozlabs.org)
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on20716.outbound.protection.outlook.com [IPv6:2a01:111:f400:feab::716])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Qrbzg4YjPz30K8
	for <linux-erofs@lists.ozlabs.org>; Wed, 28 Jun 2023 19:35:41 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FihmbyJ447UudSt4IqGYfK3PAjBxiPCAzZtt/PHxzhrFnQUC/zbwWNspaX4UhrCfWJOVGGh31J/gMuwuu98fle4dMmdqJTZIQCggqeXXUOXmd7zRLFYdg8l4fmItAogvO9kidHDvEGMk7WcADjAH4MXqLT+D5Ufcoz9lGVoRmszb6LGqZ6Tn9mkvNJy5YBHf8PssHfOJxqMYu0CS9gK3/VkkWVFweORctJpGQAQ6Ldji9RxIU45UnDbhPDGa0JJcF1kvH7+RzlhqKda/efCL5aHx+tmzHnCsKgEVuGgOvmiEYwhKVTPzYcjzAu5tMj3YiJm75sdOsfZJq1H0VNW7nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pSkxOAJdOVpvqaie33NOoEzGy7YAHeasGwTqp/veHZw=;
 b=X3tsk6u9INgaIgcjdOO8RENYQ0BpyDTF0PTFxjXsIj3mGrfMohsn/tYF0Mx8K0Rmc4Y6RncKfX2K0uKAqZzZgbah2Z2GZOCmfk/eiomGgQ85MsjiSRHYOQ1WtlOzXfZ0AABP7qQQZD1oml/7IQvUdCWQb8ZVIpxOm5QuKty6GVcP7H2RPJxHwCxH2mt/krxgHv4sLfbW8QGTNgAbavOMuM9jwQG4gSG/mc/BgDecqMMAGG6PixzOG7LASIdyR91+rr4RIBOWHCYDSYJbs0cQxTWuHpR7Tr6JhVz+cLWx2zJJyIYtXaGjJuLLlASzWOnXH8tVH0VCO9hykJFeyrbVOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pSkxOAJdOVpvqaie33NOoEzGy7YAHeasGwTqp/veHZw=;
 b=L6AZ07aa93uJqLyI/1wKgAubeBSqpn2wo1ZrU6y5gMc7QI5+ytkqCt0CbQK5OSKXZtoCUE9J1M90IfMWRwYQth9GyZlX4LLIw3VuuW2KeGhuyjhq8BCwLA1s4Az5gJykUsLdYMJ+XLVLbCi2HLVUDzM65X3F1N0GX3syR4gXEbp7OssqMsXQAhDkrC0xukP6QS5HrNAsi3EaYiMyKLtqnQEcAjFqdTbN4v8EPK5jWnEKillxaiCrOpBOKZOZ0sGR0N16TZajeGGgV9fdPoBva+rvrVJ1BAe2jZ3GNomfb0XRR6gfhytRRyQqBKdhH/++Pot3thru+fdBlPTTRi7Nqw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TYZPR06MB6144.apcprd06.prod.outlook.com (2603:1096:400:341::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Wed, 28 Jun
 2023 09:35:16 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6521.023; Wed, 28 Jun 2023
 09:35:16 +0000
From: Yangtao Li <frank.li@vivo.com>
To: axboe@kernel.dk,
	song@kernel.org,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	xiang@kernel.org,
	chao@kernel.org,
	huyue2@coolpad.com,
	jefflexu@linux.alibaba.com,
	hch@infradead.org,
	djwong@kernel.org
Subject: [PATCH 1/7] block: add queue_logical_block_mask() and bdev_logical_block_mask()
Date: Wed, 28 Jun 2023 17:34:54 +0800
Message-Id: <20230628093500.68779-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0004.apcprd04.prod.outlook.com
 (2603:1096:4:197::22) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|TYZPR06MB6144:EE_
X-MS-Office365-Filtering-Correlation-Id: 46d1fe1b-14d9-47e4-8732-08db77bafa0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	6WJnUJhgtFz1cQAx6KimKdsVgQAul6MWPn8FMkG7/atdPgSj/vvac4W5rxg+iQngOUhvzmY1KtmVcaFefX76kcnDBpw1N3sJ2bW1nShRDVG6+gYlldytiWOvWggEESmQo77Yg87nZW9g6TJaxldwgGLxJTN1Fcqkj/iga/iNl4xaYvNVWfSeuuiqOPglv9zzCz/ad/S2029igzgi+BIZFfm8ASJOeFTTb//SmLJkivcrV5kuznaN9UMhlXfUQk9v9CkXoFGTEVZAwnwDMthmMjF830Xpos0oDtvsLc8RmhnqJzmj4c0onz46hMSsZv2lYqDE2Jo6uhEairF2PodZAWOTgVCN2yDFbeeGPtvl/WLvMwZyzoxoSbHilXvTVIfvvct8F6Cgr2xkYSi0s/fkDg8M9LQY6NiZzC2hnXDZ4pOY2qyDns1SpuEBmrVQoHMGRztbIo6CfBWiLhjDqv3sz55HOvkH82noICcIpEonSkWyyI33Lvgr0mEOiUgRHz1pcbiSkFPjCqTdAQDibqccmd5Hcahcm/2f6MeengiQP1xfxPFbANp6jZUPsd3W2dKUyhMawlWcllckd4qQLuxrMgV8TbbONkFeyyjhkl4HMuGE6YTVW2RlH7sf024t9NL2jg/SWR9hAOq7YFgzhuwFvA==
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(39850400004)(376002)(366004)(136003)(451199021)(1076003)(6506007)(7416002)(5660300002)(66556008)(316002)(66946007)(36756003)(478600001)(4326008)(66476007)(8676002)(8936002)(86362001)(2906002)(6512007)(26005)(41300700001)(6666004)(6486002)(52116002)(186003)(107886003)(38350700002)(38100700002)(921005)(2616005)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?us-ascii?Q?Fop9vj2S4TkPyc51TwtDcXQqV58t1rxqS3TJgL3iujulKptyoKVRreF3KejS?=
 =?us-ascii?Q?yMPI2fp50p4DZnQo27J5wWp+4X7GsWepfvVisDSt0ZzoiHWFXFwHdOZ9Aw8t?=
 =?us-ascii?Q?Mf44a0qJHsPfah6UXL+w5OZxEDwtNDnudF2RK0oTcjhuKKI84X7S2gCf1sFt?=
 =?us-ascii?Q?mZ5vO/f1cajB/YEQGvr6SAlne720fzfelme61MUBTTYwYSrI+dqybyGFypkJ?=
 =?us-ascii?Q?WvnpXcH3JBgHX5FJZslcpHf9MWP0/KkY4bK1hA9/dqpWJwQCayy0BEbIjgVd?=
 =?us-ascii?Q?ct/akptC0ZTzrMR3J1ilRQR2H3ygdERQiVs3+GI5NhbUIhjZY/sGa9KNURU8?=
 =?us-ascii?Q?KwgcUBy7jIVgF9tyZVhdnUYzGzKaIswSvM36LbNgsx0eeKRTuJLwAy+cvOzv?=
 =?us-ascii?Q?poF0scJ/SC2FTVm3x2xrj32h2iVtPYLjXjpCz4y2Rnpo2Q7VUr+b4B4KEGjs?=
 =?us-ascii?Q?6RS65lKc/QFRaMkze6mk6Ap/PyXE1f6ZVFr7es/Y56IuROkwYOefifRZN45g?=
 =?us-ascii?Q?biaDD0PTLZo5R7E/CliHOJWoIwyekXZVFi19CWEW+F0+Cz6FRPSNes0LP+eB?=
 =?us-ascii?Q?6ySq0bZ8Qq/K/L+KJNVkZn/beCXwMwTQN5rYs+g34wgpccYKlUc1w3l3XBDY?=
 =?us-ascii?Q?O6mkdTTGzaRExEHkbDUCLcgLqShQefpwLUVq4ZCMqIyfMo6bOBJgDrJApnUI?=
 =?us-ascii?Q?QSWzE4EJKZRZrehkcN3CgEjXBlOGeX3L1fTO1NlR8Cm7Tf4HHghOkM2YJiRI?=
 =?us-ascii?Q?NYUZ4DUeQW6R7xBYetgz4Sm/xJLZy0BgyQRtNVguIOcRHu9rHI6LhQU/tYEg?=
 =?us-ascii?Q?HMxyvzEmqofiZF0gy9VWlHZqk3wztmi3nHS0WIOTUMcvdjzK1j2hUHJA2Dcy?=
 =?us-ascii?Q?mDsl3Iyagg3f+M21DCS/paD3wiKBw3bnkI8jYSWRONANXQYuo/Ha1FjK7lmv?=
 =?us-ascii?Q?/Ao8v6QZP0UTJGffyOkYm80KxAMqpN+knkeBUGG3c3Zxk7A4xKqHYUJXLKrC?=
 =?us-ascii?Q?Dkvwrn2Lvi7t8mBVYhuitjuYgMTxFh3bojXgCgsKk6jo2yGTnQsH3QHWIyZj?=
 =?us-ascii?Q?QzZXojmGdNYXzeTFEB52j1erCPqIgs5OniqeomteygrZuTXiUl0+GW8kQibT?=
 =?us-ascii?Q?3GksEixBY/5Dx+hi6bOypNII7jxDOF0Z4RWhAk61ONBStm6SOqN+SrrNAouV?=
 =?us-ascii?Q?mUd/tqYLTcgwQ0Bgp2P4xYtjcF4SutF05Qaa7Jli5PkvumKXQfmI+kyTMMnm?=
 =?us-ascii?Q?rhsB31KK2oNVKdLLTCsABpZvc7rgFDNG928h7nv2Jsz0SPowGM68uYEn7Y+X?=
 =?us-ascii?Q?htKfvIXPTesbdh2vjtwLFydKYL1ryukTMvsQXjrWP3qEk7koSb8r0zFeFqct?=
 =?us-ascii?Q?tdKP66zIb7hSSqDbWGziVIZpiJtqcM7GLBGJnctPZa/S+zoFLow1PKe3gvCZ?=
 =?us-ascii?Q?0bIyLCh04y3OQZZOTOifUuF3xCDogGRSZ2Fmb4PokVzbTKt8PJD1NUzz77rO?=
 =?us-ascii?Q?896OIsokdZTMqmj06g8m1Vmd2PR3rd50DGk5LdTs2ohE1XEp7NrJ97eeeAk+?=
 =?us-ascii?Q?01R79wbI3WGe2NryFdHnta7FooZ0o4pJ+1GqCA7e?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46d1fe1b-14d9-47e4-8732-08db77bafa0c
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2023 09:35:15.6511
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0gvVjgag0e6ZHoovRVcPOUPSffQpa07qYtUQkKaP95a/P6axewaW4czLSmACfPE2Ac4W2pH9K05EfWwTVtsrsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6144
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
Cc: linux-raid@vger.kernel.org, Yangtao Li <frank.li@vivo.com>, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org, linux-xfs@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Introduce queue_logical_block_mask() and bdev_logical_block_mask()
to simplify code, which replace (queue_logical_block_size(q) - 1)
and (bdev_logical_block_size(bdev) - 1).

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 include/linux/blkdev.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index ed44a997f629..0cc0d1694ef6 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1150,11 +1150,21 @@ static inline unsigned queue_logical_block_size(const struct request_queue *q)
 	return retval;
 }
 
+static inline unsigned int queue_logical_block_mask(const struct request_queue *q)
+{
+	return queue_logical_block_size(q) - 1;
+}
+
 static inline unsigned int bdev_logical_block_size(struct block_device *bdev)
 {
 	return queue_logical_block_size(bdev_get_queue(bdev));
 }
 
+static inline unsigned int bdev_logical_block_mask(struct block_device *bdev)
+{
+	return bdev_logical_block_size(bdev) - 1;
+}
+
 static inline unsigned int queue_physical_block_size(const struct request_queue *q)
 {
 	return q->limits.physical_block_size;
-- 
2.39.0

