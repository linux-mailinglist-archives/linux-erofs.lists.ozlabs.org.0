Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FDE212E61C
	for <lists+linux-erofs@lfdr.de>; Thu,  2 Jan 2020 13:29:28 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47pS5d4sNpzDqBL
	for <lists+linux-erofs@lfdr.de>; Thu,  2 Jan 2020 23:29:25 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 47pS5X052WzDqB0
 for <linux-erofs@lists.ozlabs.org>; Thu,  2 Jan 2020 23:29:19 +1100 (AEDT)
Received: from pps.filterd (mgw-01.mpynet.fi [127.0.0.1])
 by mgw-01.mpynet.fi (8.16.0.27/8.16.0.27) with SMTP id 002Bxd4G065936;
 Thu, 2 Jan 2020 14:01:38 +0200
Received: from ex13.tuxera.com (ex13.tuxera.com [178.16.184.72])
 by mgw-01.mpynet.fi with ESMTP id 2x9egur3n4-4
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
 Thu, 02 Jan 2020 14:01:38 +0200
Received: from localhost (194.100.106.190) by tuxera-exch.ad.tuxera.com
 (10.20.48.11) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 2 Jan
 2020 14:01:37 +0200
From: Vladimir Zapolskiy <vladimir@tuxera.com>
To: Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>
Subject: [PATCH 2/3] erofs: remove unused tag argument while registering a
 workgroup
Date: Thu, 2 Jan 2020 14:01:17 +0200
Message-ID: <20200102120118.14979-3-vladimir@tuxera.com>
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

All workgroups are registered with tag value set to 0, to simplify
erofs_register_workgroup() interface the tag argument can be removed,
if its only value is sent down to the function body.

Signed-off-by: Vladimir Zapolskiy <vladimir@tuxera.com>
---
 fs/erofs/internal.h | 2 +-
 fs/erofs/utils.c    | 5 ++---
 fs/erofs/zdata.c    | 2 +-
 3 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 55f7560cf1b4..926824578954 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -403,7 +403,7 @@ int erofs_workgroup_put(struct erofs_workgroup *grp);
 struct erofs_workgroup *erofs_find_workgroup(struct super_block *sb,
 					     pgoff_t index);
 int erofs_register_workgroup(struct super_block *sb,
-			     struct erofs_workgroup *grp, bool tag);
+			     struct erofs_workgroup *grp);
 void erofs_workgroup_free_rcu(struct erofs_workgroup *grp);
 void erofs_shrinker_register(struct super_block *sb);
 void erofs_shrinker_unregister(struct super_block *sb);
diff --git a/fs/erofs/utils.c b/fs/erofs/utils.c
index 4d1cf4d00dab..7b47c56b89b7 100644
--- a/fs/erofs/utils.c
+++ b/fs/erofs/utils.c
@@ -83,8 +83,7 @@ struct erofs_workgroup *erofs_find_workgroup(struct super_block *sb,
 }
 
 int erofs_register_workgroup(struct super_block *sb,
-			     struct erofs_workgroup *grp,
-			     bool tag)
+			     struct erofs_workgroup *grp)
 {
 	struct erofs_sb_info *sbi;
 	int err;
@@ -102,7 +101,7 @@ int erofs_register_workgroup(struct super_block *sb,
 	sbi = EROFS_SB(sb);
 	xa_lock(&sbi->workstn_tree);
 
-	grp = xa_tag_pointer(grp, tag);
+	grp = xa_tag_pointer(grp, 0);
 
 	/*
 	 * Bump up reference count before making this workgroup
diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 052d28391ce6..4fedeb4496e4 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -437,7 +437,7 @@ static int z_erofs_register_collection(struct z_erofs_collector *clt,
 	 */
 	mutex_trylock(&cl->lock);
 
-	err = erofs_register_workgroup(inode->i_sb, &pcl->obj, 0);
+	err = erofs_register_workgroup(inode->i_sb, &pcl->obj);
 	if (err) {
 		mutex_unlock(&cl->lock);
 		kmem_cache_free(pcluster_cachep, pcl);
-- 
2.20.1

