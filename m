Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 536DD606D95
	for <lists+linux-erofs@lfdr.de>; Fri, 21 Oct 2022 04:23:01 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MtpCj6WK5z3dqW
	for <lists+linux-erofs@lfdr.de>; Fri, 21 Oct 2022 13:22:57 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1666318977;
	bh=K8n3hu8gsmNnf0snz6xQchFocXq9/Kk9WeHFAHivz+U=;
	h=To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=j5U/vUHp1ADm47gCtLJIeV8yYNKEi5emnvb0PFZFnl4jMlOmgKxotLfpgZoyomzqF
	 6Ssqb19hWY/NZa+2sagGUO8zC4geUANPWE8v9JoVOGd+vYE/615zywToO7dqk5B+Ys
	 BoTuNc18BaLXU88O4G8U/yW2OkCFBy8xr5mcurFRSBcp6vPkFTTx5fmlEVN2/WQr9z
	 vh6dDvprwataRc+4aonkZTACeHEqUxd70Sm0GXRu/O0vNtLzf3AZqtABnIKlsnvD1a
	 FYzPR6hJcp72tukQ1B3FEtbmJP+NRDiz8LG58mmHtb6PT+0QP+ugONeMr76XDYI72C
	 LN3MPOAx7zUQw==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=45.249.212.188; helo=szxga02-in.huawei.com; envelope-from=yangyingliang@huawei.com; receiver=<UNKNOWN>)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MtpCY5D1jz2ywV
	for <linux-erofs@lists.ozlabs.org>; Fri, 21 Oct 2022 13:22:44 +1100 (AEDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.57])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MtpC82VSGzHvDB;
	Fri, 21 Oct 2022 10:22:28 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 21 Oct 2022 10:22:36 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 21 Oct
 2022 10:22:35 +0800
To: <linux-kernel@vger.kernel.org>, <qemu-devel@nongnu.org>,
	<linux-f2fs-devel@lists.sourceforge.net>, <linux-erofs@lists.ozlabs.org>,
	<ocfs2-devel@oss.oracle.com>, <linux-mtd@lists.infradead.org>,
	<amd-gfx@lists.freedesktop.org>
Subject: [PATCH 00/11] fix memory leak while kset_register() fails
Date: Fri, 21 Oct 2022 10:20:51 +0800
Message-ID: <20221021022102.2231464-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
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
From: Yang Yingliang via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Yang Yingliang <yangyingliang@huawei.com>
Cc: alexander.deucher@amd.com, richard@nod.at, mst@redhat.com, gregkh@linuxfoundation.org, somlo@cmu.edu, huangjianan@oppo.com, liushixin2@huawei.com, joseph.qi@linux.alibaba.com, luben.tuikov@amd.com, jlbec@evilplan.org, hsiangkao@linux.alibaba.com, rafael@kernel.org, jaegeuk@kernel.org, akpm@linux-foundation.org, mark@fasheh.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

The previous discussion link:
https://lore.kernel.org/lkml/0db486eb-6927-927e-3629-958f8f211194@huawei.com/T/

kset_register() is currently used in some places without calling
kset_put() in error path, because the callers think it should be
kset internal thing to do, but the driver core can not know what
caller doing with that memory at times. The memory could be freed
both in kset_put() and error path of caller, if it is called in
kset_register().

So make the function documentation more explicit about calling
kset_put() in the error path of caller first, so that people
have a chance to know what to do here, then fixes this leaks
by calling kset_put() from callers.

Liu Shixin (1):
  ubifs: Fix memory leak in ubifs_sysfs_init()

Yang Yingliang (10):
  kset: fix documentation for kset_register()
  kset: add null pointer check in kset_put()
  bus: fix possible memory leak in bus_register()
  kobject: fix possible memory leak in kset_create_and_add()
  class: fix possible memory leak in __class_register()
  firmware: qemu_fw_cfg: fix possible memory leak in
    fw_cfg_build_symlink()
  f2fs: fix possible memory leak in f2fs_init_sysfs()
  erofs: fix possible memory leak in erofs_init_sysfs()
  ocfs2: possible memory leak in mlog_sys_init()
  drm/amdgpu/discovery: fix possible memory leak

 drivers/base/bus.c                            | 4 +++-
 drivers/base/class.c                          | 6 ++++++
 drivers/firmware/qemu_fw_cfg.c                | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 5 +++--
 fs/erofs/sysfs.c                              | 4 +++-
 fs/f2fs/sysfs.c                               | 4 +++-
 fs/ocfs2/cluster/masklog.c                    | 7 ++++++-
 fs/ubifs/sysfs.c                              | 2 ++
 include/linux/kobject.h                       | 3 ++-
 lib/kobject.c                                 | 5 ++++-
 10 files changed, 33 insertions(+), 9 deletions(-)

-- 
2.25.1

