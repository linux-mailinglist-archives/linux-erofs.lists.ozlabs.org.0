Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id C3B04588E9A
	for <lists+linux-erofs@lfdr.de>; Wed,  3 Aug 2022 16:23:42 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4LyYxm4fVJz3bZY
	for <lists+linux-erofs@lfdr.de>; Thu,  4 Aug 2022 00:23:40 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1659536620;
	bh=h6xlvLKyKIsRpON8w/hQLOKK5Ma3HgqmpzvpjIiybLQ=;
	h=To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=KtHpYX16Ok5CU1Tg2J2YFCGZZaj2f3qJYwgV8ig8NRpi0rrp8NRFa6cuyWNIYVLPb
	 1MAptFyh5Bi34FF/1UV/IebnYR1pq3qnh3+vZrMeY9H0jqWIehzAj14S11i2TqrXH8
	 rXWtU5LNKERu6I7NTc2z4knsKB9A2DznMNElUWm2pBqto1ucqiGybLt2wbkltaEXrK
	 oF0V1fxeyXGUqhRlZYIbYBks3uzADN7/05y5uWK+rTs1HXY+OYxV/rXEEWZ1Np5E0o
	 R+aiGZqnt3HRrh9FLnktrnc3CjLsJ38VFkzXSqFeymD1JuFzBJSeIrRHTbTSb3O2wb
	 TjHE49rfsw6WQ==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oppo.com (client-ip=40.107.117.44; helo=apc01-tyz-obe.outbound.protection.outlook.com; envelope-from=shengyong@oppo.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=oppo.com header.i=@oppo.com header.a=rsa-sha256 header.s=selector1 header.b=lzlubWhb;
	dkim-atps=neutral
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2044.outbound.protection.outlook.com [40.107.117.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4LyYxY6nHfz2yMk
	for <linux-erofs@lists.ozlabs.org>; Thu,  4 Aug 2022 00:23:27 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BcrFiGOX+UAS4vTnUC1JKY2f6lchrrBa03hyWhyPOXwlpSNRXdjuwB53r+PJLF38Y3is6GY3vPCbxqb0gzvvoZ12qbWSNJzxw5C7YGym/IRhwQ27NyuMhj5zNxm4kG1no/IWAkQlrgNY+ZKYXRDefP6r0fNblLNbNN86AqbbyVqQXmMPq1AJVdpH8P9XxaY1kGfWIIKBwsrr6S4Ubfjz1I1mQT9to/rboUAWMLd9nHwL4FHhYWIADjdnYEKT6MtjN1NjlTqab/RkeRIzWbyQJ7hT8OPc1Pypt4iCdix9LT88TISi79q2swlxlKWltOSRuegmc1PkakZR/3crs/OWJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h6xlvLKyKIsRpON8w/hQLOKK5Ma3HgqmpzvpjIiybLQ=;
 b=Ye9hHcVh+7V6zjSH4ycWdEWquRo7lYfg+ST3zJMT1+evdG7ZOvU274/C3eH1fco/EnAibqbOOV/ZbUp66OdbuOHA57UU9rdTnADGIftuK9L3jyInRh3kqOZlmTs1AWJfynl8Ktq87/fh/HXrECqzlo1o494vWSgYJVJhd/+q8t9KEMeeeWOf/2AUEcCoK0S8lRfg1q9wFRrFwiZrkAn883w9t6HbCkWS/zuQwKGqzjoLiDlEgd/qSG87+DsWR2dOANuwJFQUrEzUNzJZy9yn55rPanSRbYBQSGKj5CeCNv3I4KASr8odqD1q9wIqSsawzqEc3Fb7ZomwVvJn2FM9/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oppo.com;
Received: from SI2PR02MB5148.apcprd02.prod.outlook.com (2603:1096:4:153::6) by
 SI2PR02MB6038.apcprd02.prod.outlook.com (2603:1096:4:1fd::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5504.14; Wed, 3 Aug 2022 14:23:03 +0000
Received: from SI2PR02MB5148.apcprd02.prod.outlook.com
 ([fe80::adea:6739:ab8a:9adf]) by SI2PR02MB5148.apcprd02.prod.outlook.com
 ([fe80::adea:6739:ab8a:9adf%3]) with mapi id 15.20.5504.014; Wed, 3 Aug 2022
 14:23:03 +0000
To: xiang@kernel.org,
	bluce.lee@aliyun.com,
	linux-erofs@lists.ozlabs.org,
	chao@kernel.org
Subject: [RFC PATCH 0/3] erofs-utils: fuse: support get/list xattr
Date: Wed,  3 Aug 2022 22:22:20 +0800
Message-Id: <20220803142223.3962974-1-shengyong@oppo.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: SGXP274CA0017.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::29)
 To SI2PR02MB5148.apcprd02.prod.outlook.com (2603:1096:4:153::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 69e3a382-b626-4264-34a2-08da755bacbe
X-MS-TrafficTypeDiagnostic: SI2PR02MB6038:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	1eo/EtnVdfURPDOHJP0qKI/jDDBlz1m4BLr1f8gsMtmHg/x4YoMkPCm5PxzMC9Sspcf39PofewmQ2oXRXaB+wV4LVCJxubXbd6tU+6tz1zEVe9ij76LvLcBz7fVRoDdlPzFJvlLWyR5GNIjoBHIS0eirWRNjTvEnQcp7rQ2IK+oUUqRF4XLXEy7hTZPTRgApKe1lfNvwkyDJAh18haRjLkCiuk/1DQajYLvOUvwvyKdQA+Kj/+Fajbi3yV1XgHl0HvL89WG2UhGeMZ/aaL5H3SNbO0eFyO7TqKXYrD6MxlpfhDgck+PQ12fDqDYYM9ukxyAXTvsp/8Y/vsiWfTGvRzOIAONX1WZlnRN+9AMnZ87rxd7MPdmF4Fz6qCulEiknXQHU3c0hks4YFiK5LFdO0QUKVajr6+P8h9QH5xW8YpegMtE8GFvVP8rYJkjLF+rr0CE6gKKsFqPldyRAqDtUw8LgO39Ggid9HpTgtGdT5+xff4JLctSXKY6UYWZyLEMJFRquMShIzuT1UHy3qqcUFlMN9wjo+iyPXQAu3/9mLK4aA1yPt3cXtPXwYQMomRkddN45w9ALjGwFVw7WpdjcxRzvfKfwaEVZGtS/1KbYDb5DjGBwIMHdXZvh3npgyZi/3Tda5lCknpFDSTtaCQzACPejZGpybYAbI6IP7x5fCSly5TE+PVRdAosChaliKuC7704aE6tyWWa6hVP2VE8KJv0D4EbIFfU8BvZPMKf+yXwzDJVznCT5N4jPnxPsnwtmM6Co1s1RKIZ5PcfhmjeW86c9uTP/gHPbyrHjHc24Y0A=
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR02MB5148.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(346002)(376002)(396003)(39860400002)(136003)(38350700002)(86362001)(38100700002)(5660300002)(107886003)(186003)(83380400001)(2906002)(1076003)(2616005)(36756003)(6666004)(41300700001)(6512007)(6506007)(316002)(52116002)(26005)(4326008)(66476007)(66556008)(66946007)(6486002)(8936002)(8676002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?us-ascii?Q?zUQVZde4bmUViHQIDzhGhjjkVqcJ8bJCPptgDMpThBg31jRreHW4riA7tbxT?=
 =?us-ascii?Q?SFoZsbbpWFe5Y9k/4vid3x58QeDAU5Sq11WWvHklqwt0GTtNfCRTtSVHApWH?=
 =?us-ascii?Q?HiU0IWo9zpNFBB0eUUxFWye/1zbgmNzJsAawDxoS91d1YAOR5akd0XxcjI7K?=
 =?us-ascii?Q?Wi4ur1CAGdKit6Ughu6+nLdUi5o8puLH4XCKbrQVdqqB1UDFAO872IoFc1Gh?=
 =?us-ascii?Q?DC6YbUu/8BSIos55SNTSCQ58rplOfdRgy3/aVAh64VvRgYfOB2kqI7DuTIY0?=
 =?us-ascii?Q?AhKM280mLNuL1wqrj7g98HqAmpUrLqVOhBpTX16zQv9eW8/KWG2pksVX4cac?=
 =?us-ascii?Q?K0GjeykqIzpqga3pY9aKNkUVcrO4chdMOF9ZUUzEQXWlNbc5mnMNbvsWsXPh?=
 =?us-ascii?Q?HSNbHNzAvDtnYWQEtPCAZku4r0khh5f76uzASVGyD9C5Hvh4h/cABSRatlm8?=
 =?us-ascii?Q?3ip6f2t38xRmREJtdNvo7uGzuPaskx6HnvrC3D/5sqBfgRtrBggcWvJKeeTG?=
 =?us-ascii?Q?BrGjpQhqY0w7zz8xAyPa/RzYcPHNaSYRSz/x+5eScTY4CtALjTRvR7c8FSu3?=
 =?us-ascii?Q?k9ZjL0k1AI/RJCDDwrYNXXV+ivedD25l1YBxTbN8DKFbhF41bRIzh0kQuJKe?=
 =?us-ascii?Q?CvJ9uAaIqBf5iWNqDYhBZHj2nIKJniy4yp4AlwSecEpuSsio6Bj+xLKD9i7B?=
 =?us-ascii?Q?7qN5DTt4q7oi+6rSmUd+11Du8om8GlMnvJs2qI6q+8HKQCY8EfmQD/pbX8td?=
 =?us-ascii?Q?H2XKpQg2eyaL2ieKASF4+OJ+W8C/yE2dFG+KWSft5AtEsmI0Tdkyg+M5pJtN?=
 =?us-ascii?Q?AJVHZhvaa8q0Tu07Lp7uFZs8qvRlUGdiOB9D9g/Ufx5FDmEcpt4pXi9bp4+Q?=
 =?us-ascii?Q?WUFzOE+jvAvcvN9O1tV6guakg84OvDHKuk9GZb1bRM9oLM0F54TDIkyBArgJ?=
 =?us-ascii?Q?4SvXzaGEHbH9AL90rsHBG0b62FUN06BUX3jhMB9b4gfr1x94+ixQgHI90jtG?=
 =?us-ascii?Q?h5hnCzIghBDn1D90WFqwTwlFglbo7Oj/cKkYUTVOMKBVL6aQxnchhiV8pJT3?=
 =?us-ascii?Q?yDLwdPF24ZiMcDHNxQVB9zMQvLO0cC1UuG2WHJUKzojvxiT+/A160tgE2spo?=
 =?us-ascii?Q?QTKhyCHQRzOx8VHkmaCLStpn31PCFIeZHkT7kS0eKx+9rjepFD6i+JKUsN7p?=
 =?us-ascii?Q?bdNlluRb20rW9gLFHSHIjZ4q0CaQmdarKFsR6k9vkPgTMznuGPlv6JobPz4l?=
 =?us-ascii?Q?JXEU3f4FzttlQpl/YFeVbn24wn8sLVUSVW9vUPANrZ8BNbt2PJWDNevW99Bs?=
 =?us-ascii?Q?jHwAcLwz11kzLJ0msAab1Cy21lfKdYCSeCxNjehQs0f0JBSKhFT5OFKLBJAs?=
 =?us-ascii?Q?TNmWfuisWcP3pYI09lJ7544voCM/TYa8R72QfrOE+fcsbqHjpY/ZwZ0JzU54?=
 =?us-ascii?Q?h96JEtN/igNRFzOjl3wb3ulDmxj3fv5+lM83Gb5i9Zzn9qK2XLDCdPith5Ck?=
 =?us-ascii?Q?SADWa1uxCuFR+nLe7DPJMyAMJpYCt8kZsv2YZH1CovZbtgZCxHsdovEWjS9g?=
 =?us-ascii?Q?BgeQntcq/GLg9FsCq1MirPhDjonMUx5Tx0A/4DEb?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69e3a382-b626-4264-34a2-08da755bacbe
X-MS-Exchange-CrossTenant-AuthSource: SI2PR02MB5148.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2022 14:23:02.8997
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C3X6iJ3ClJrf3YDNrFSmsNXwqWANTDj9YCLr/CvuylY2HBbaRoDsndrQYO9PhcuTUWYj+OY9QEHgjroduc4+qg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR02MB6038
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
From: Sheng Yong via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Sheng Yong <shengyong@oppo.com>
Cc: shengyong@oppo.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi erofs folks,

I tried to make an erofs image based on an existing image. However,
the fuse client does not support xattr operations, so that the new
image cannot inherit xattrs from the old one which is mouted through
fuse.

So this patchset adds xattr support for erofs fuse client. Besides,
readdir is also modified to help mkfs.erofs get the correct file
type.

Sheng Yong (3):
  erofs-utils: fuse: set d_type for readdir
  erofs-utils: fuse: export erofs_xattr_foreach
  erofs-utils: fuse: support get/list xattr

 fsck/main.c           |  85 ++++--------------------
 fuse/main.c           | 140 ++++++++++++++++++++++++++++++++++++++-
 include/erofs/inode.h |   1 +
 include/erofs/xattr.h |  15 ++++-
 lib/inode.c           |  19 ++++++
 lib/xattr.c           | 149 ++++++++++++++++++++++++++++++++++++++++--
 6 files changed, 330 insertions(+), 79 deletions(-)

--
2.25.1

________________________________
OPPO

=E6=9C=AC=E7=94=B5=E5=AD=90=E9=82=AE=E4=BB=B6=E5=8F=8A=E5=85=B6=E9=99=84=E4=
=BB=B6=E5=90=AB=E6=9C=89OPPO=E5=85=AC=E5=8F=B8=E7=9A=84=E4=BF=9D=E5=AF=86=
=E4=BF=A1=E6=81=AF=EF=BC=8C=E4=BB=85=E9=99=90=E4=BA=8E=E9=82=AE=E4=BB=B6=E6=
=8C=87=E6=98=8E=E7=9A=84=E6=94=B6=E4=BB=B6=E4=BA=BA=E4=BD=BF=E7=94=A8=EF=BC=
=88=E5=8C=85=E5=90=AB=E4=B8=AA=E4=BA=BA=E5=8F=8A=E7=BE=A4=E7=BB=84=EF=BC=89=
=E3=80=82=E7=A6=81=E6=AD=A2=E4=BB=BB=E4=BD=95=E4=BA=BA=E5=9C=A8=E6=9C=AA=E7=
=BB=8F=E6=8E=88=E6=9D=83=E7=9A=84=E6=83=85=E5=86=B5=E4=B8=8B=E4=BB=A5=E4=BB=
=BB=E4=BD=95=E5=BD=A2=E5=BC=8F=E4=BD=BF=E7=94=A8=E3=80=82=E5=A6=82=E6=9E=9C=
=E6=82=A8=E9=94=99=E6=94=B6=E4=BA=86=E6=9C=AC=E9=82=AE=E4=BB=B6=EF=BC=8C=E8=
=AF=B7=E7=AB=8B=E5=8D=B3=E4=BB=A5=E7=94=B5=E5=AD=90=E9=82=AE=E4=BB=B6=E9=80=
=9A=E7=9F=A5=E5=8F=91=E4=BB=B6=E4=BA=BA=E5=B9=B6=E5=88=A0=E9=99=A4=E6=9C=AC=
=E9=82=AE=E4=BB=B6=E5=8F=8A=E5=85=B6=E9=99=84=E4=BB=B6=E3=80=82

This e-mail and its attachments contain confidential information from OPPO,=
 which is intended only for the person or entity whose address is listed ab=
ove. Any use of the information contained herein in any way (including, but=
 not limited to, total or partial disclosure, reproduction, or disseminatio=
n) by persons other than the intended recipient(s) is prohibited. If you re=
ceive this e-mail in error, please notify the sender by phone or email imme=
diately and delete it!
