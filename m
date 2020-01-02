Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id A036B12E611
	for <lists+linux-erofs@lfdr.de>; Thu,  2 Jan 2020 13:27:31 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47pS3N3CJBzDqB5
	for <lists+linux-erofs@lfdr.de>; Thu,  2 Jan 2020 23:27:28 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=tuxera.com (client-ip=82.197.21.90; helo=mgw-01.mpynet.fi;
 envelope-from=vladimir@tuxera.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=tuxera.com
Received: from mgw-01.mpynet.fi (mgw-01.mpynet.fi [82.197.21.90])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47pS3F69TPzDq7g
 for <linux-erofs@lists.ozlabs.org>; Thu,  2 Jan 2020 23:27:21 +1100 (AEDT)
Received: from pps.filterd (mgw-01.mpynet.fi [127.0.0.1])
 by mgw-01.mpynet.fi (8.16.0.27/8.16.0.27) with SMTP id 002Bxd4D065936;
 Thu, 2 Jan 2020 14:01:37 +0200
Received: from ex13.tuxera.com (ex13.tuxera.com [178.16.184.72])
 by mgw-01.mpynet.fi with ESMTP id 2x9egur3n4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
 Thu, 02 Jan 2020 14:01:37 +0200
Received: from localhost (194.100.106.190) by tuxera-exch.ad.tuxera.com
 (10.20.48.11) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 2 Jan
 2020 14:01:37 +0200
From: Vladimir Zapolskiy <vladimir@tuxera.com>
To: Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>
Subject: [PATCH 0/3] erofs: remove tags of pointers stored in a radix tree
Date: Thu, 2 Jan 2020 14:01:15 +0200
Message-ID: <20200102120118.14979-1-vladimir@tuxera.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [194.100.106.190]
X-ClientProxiedBy: tuxera-exch.ad.tuxera.com (10.20.48.11) To
 tuxera-exch.ad.tuxera.com (10.20.48.11)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2020-01-02_03:, , signatures=0
X-Proofpoint-Spam-Details: rule=mpy_notspam policy=mpy score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=838
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001020108
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
Cc: linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 Matthew Wilcox <willy@infradead.org>, Anton Altaparmakov <anton@tuxera.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

The changeset simplifies a couple of internal interfaces and removes
excessive tagging and untagging of workgroup pointers stored in a radix
tree.

All the changes in the series are non-functional.

Vladimir Zapolskiy (3):
  erofs: remove unused tag argument while finding a workgroup
  erofs: remove unused tag argument while registering a workgroup
  erofs: remove void tagging/untagging of workgroup pointers

 fs/erofs/internal.h |  4 ++--
 fs/erofs/utils.c    | 15 ++++-----------
 fs/erofs/zdata.c    |  5 ++---
 3 files changed, 8 insertions(+), 16 deletions(-)

-- 
2.20.1

