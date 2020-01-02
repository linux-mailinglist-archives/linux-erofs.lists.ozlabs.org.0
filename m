Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id C3EEC12E61D
	for <lists+linux-erofs@lfdr.de>; Thu,  2 Jan 2020 13:29:36 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47pS5p27fhzDqBK
	for <lists+linux-erofs@lfdr.de>; Thu,  2 Jan 2020 23:29:34 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 47pS5X03bWzDq9y
 for <linux-erofs@lists.ozlabs.org>; Thu,  2 Jan 2020 23:29:19 +1100 (AEDT)
Received: from pps.filterd (mgw-01.mpynet.fi [127.0.0.1])
 by mgw-01.mpynet.fi (8.16.0.27/8.16.0.27) with SMTP id 002Bxd4E065936;
 Thu, 2 Jan 2020 14:01:37 +0200
Received: from ex13.tuxera.com (ex13.tuxera.com [178.16.184.72])
 by mgw-01.mpynet.fi with ESMTP id 2x9egur3n4-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
 Thu, 02 Jan 2020 14:01:37 +0200
Received: from localhost (194.100.106.190) by tuxera-exch.ad.tuxera.com
 (10.20.48.11) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 2 Jan
 2020 14:01:37 +0200
From: Vladimir Zapolskiy <vladimir@tuxera.com>
To: Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>
Subject: [PATCH 1/3] erofs: remove unused tag argument while finding a
 workgroup
Date: Thu, 2 Jan 2020 14:01:16 +0200
Message-ID: <20200102120118.14979-2-vladimir@tuxera.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200102120118.14979-1-vladimir@tuxera.com>
References: <20200102120118.14979-1-vladimir@tuxera.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [194.100.106.190]
X-ClientProxiedBy: tuxera-exch.ad.tuxera.com (10.20.48.11) To
 tuxera-exch.ad.tuxera.com (10.20.48.11)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2020-01-02_03:, , signatures=0
X-Proofpoint-Spam-Details: rule=mpy_notspam policy=mpy score=0 suspectscore=2
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
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

It is feasible to simplify erofs_find_workgroup() interface by removing
an unused function argument. While formally the argument is used in the
function itself, its assigned value is ignored on the caller side.

Signed-off-by: Vladimir Zapolskiy <vladimir@tuxera.com>
---
 fs/erofs/internal.h | 2 +-
 fs/erofs/utils.c    | 3 +--
 fs/erofs/zdata.c    | 3 +--
 3 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index a5fac25db6af..55f7560cf1b4 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -401,7 +401,7 @@ static inline void *erofs_get_pcpubuf(unsigned int pagenr)
 #ifdef CONFIG_EROFS_FS_ZIP
 int erofs_workgroup_put(struct erofs_workgroup *grp);
 struct erofs_workgroup *erofs_find_workgroup(struct super_block *sb,
-					     pgoff_t index, bool *tag);
+					     pgoff_t index);
 int erofs_register_workgroup(struct super_block *sb,
 			     struct erofs_workgroup *grp, bool tag);
 void erofs_workgroup_free_rcu(struct erofs_workgroup *grp);
diff --git a/fs/erofs/utils.c b/fs/erofs/utils.c
index 1e8e1450d5b0..4d1cf4d00dab 100644
--- a/fs/erofs/utils.c
+++ b/fs/erofs/utils.c
@@ -59,7 +59,7 @@ static int erofs_workgroup_get(struct erofs_workgroup *grp)
 }
 
 struct erofs_workgroup *erofs_find_workgroup(struct super_block *sb,
-					     pgoff_t index, bool *tag)
+					     pgoff_t index)
 {
 	struct erofs_sb_info *sbi = EROFS_SB(sb);
 	struct erofs_workgroup *grp;
@@ -68,7 +68,6 @@ struct erofs_workgroup *erofs_find_workgroup(struct super_block *sb,
 	rcu_read_lock();
 	grp = radix_tree_lookup(&sbi->workstn_tree, index);
 	if (grp) {
-		*tag = xa_pointer_tag(grp);
 		grp = xa_untag_pointer(grp);
 
 		if (erofs_workgroup_get(grp)) {
diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index ca99425a4536..052d28391ce6 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -345,9 +345,8 @@ static int z_erofs_lookup_collection(struct z_erofs_collector *clt,
 	struct z_erofs_pcluster *pcl;
 	struct z_erofs_collection *cl;
 	unsigned int length;
-	bool tag;
 
-	grp = erofs_find_workgroup(inode->i_sb, map->m_pa >> PAGE_SHIFT, &tag);
+	grp = erofs_find_workgroup(inode->i_sb, map->m_pa >> PAGE_SHIFT);
 	if (!grp)
 		return -ENOENT;
 
-- 
2.20.1

