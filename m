Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id D80565BBC76
	for <lists+linux-erofs@lfdr.de>; Sun, 18 Sep 2022 10:03:45 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MVgL34JBkz304y
	for <lists+linux-erofs@lfdr.de>; Sun, 18 Sep 2022 18:03:39 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=YFjie30H;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.55.52.88; helo=mga01.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=YFjie30H;
	dkim-atps=neutral
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MVgKw6J6Xz2xKf
	for <linux-erofs@lists.ozlabs.org>; Sun, 18 Sep 2022 18:03:27 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663488213; x=1695024213;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=1xbNfYIc0IdkEiL/rGnJalGBADaXFrjWxqTZIXfpC58=;
  b=YFjie30HOcNx5GrS9U6QK1VttnC1XSTPoZqONYJSCjc9q0Q6sm40jmkH
   a0p/b01KJ4X5zY4BSTD9UM01sLWjWkj+o3C1Nd9RC3uddjV1Cl9zQ003g
   Kka2/1ESU9LTl2qWKQ6N79ZEfRJRaXg5Ers49/DphiCC7N5c5mAOuE1oV
   eN0dscXLa6eQcDH1Uw9z93eM9HLYez60YNMoifE2bTBahqdSNwpoA9HMM
   2ZzoaTv/YaMmoGnZxz1KDp/O7wDRKhVsByvd+iGmFQWFxq18HC0g3Cjin
   S7KGdiFWxJYtXb0yazZMhEVF1oKEDweKVcZtKMApIZvXHcoPYkUzSb40p
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10473"; a="325496871"
X-IronPort-AV: E=Sophos;i="5.93,325,1654585200"; 
   d="scan'208";a="325496871"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2022 01:03:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,325,1654585200"; 
   d="scan'208";a="686621227"
Received: from lkp-server01.sh.intel.com (HELO c0a60f19fe7e) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 18 Sep 2022 01:03:23 -0700
Received: from kbuild by c0a60f19fe7e with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1oZpGs-00011h-1B;
	Sun, 18 Sep 2022 08:03:22 +0000
Date: Sun, 18 Sep 2022 16:02:57 +0800
From: kernel test robot <lkp@intel.com>
To: Jia Zhu <zhujia.zj@bytedance.com>
Subject: [xiang-erofs:dev-test 5/6] fs/erofs/fscache.c:535:23: warning: no
 previous prototype for function 'erofs_fscache_acquire_cookie'
Message-ID: <202209181550.IB5iSy64-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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
Cc: linux-erofs@lists.ozlabs.org, llvm@lists.linux.dev, kbuild-all@lists.01.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git dev-test
head:   73ac9605cc83179e0d44a8c64d85ab81d5d7a57e
commit: 0c8acee18add4f65597f6a2a3111256bee50ffc8 [5/6] erofs: Support sharing cookies in the same domain
config: hexagon-randconfig-r025-20220918 (https://download.01.org/0day-ci/archive/20220918/202209181550.IB5iSy64-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 791a7ae1ba3efd6bca96338e10ffde557ba83920)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git/commit/?id=0c8acee18add4f65597f6a2a3111256bee50ffc8
        git remote add xiang-erofs https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git
        git fetch --no-tags xiang-erofs dev-test
        git checkout 0c8acee18add4f65597f6a2a3111256bee50ffc8
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash fs/erofs/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> fs/erofs/fscache.c:535:23: warning: no previous prototype for function 'erofs_fscache_acquire_cookie' [-Wmissing-prototypes]
   struct erofs_fscache *erofs_fscache_acquire_cookie(struct super_block *sb,
                         ^
   fs/erofs/fscache.c:535:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   struct erofs_fscache *erofs_fscache_acquire_cookie(struct super_block *sb,
   ^
   static 
   1 warning generated.


vim +/erofs_fscache_acquire_cookie +535 fs/erofs/fscache.c

   534	
 > 535	struct erofs_fscache *erofs_fscache_acquire_cookie(struct super_block *sb,
   536							    char *name, bool need_inode)
   537	{
   538		struct fscache_volume *volume = EROFS_SB(sb)->volume;
   539		struct erofs_fscache *ctx;
   540		struct fscache_cookie *cookie;
   541		int ret;
   542	
   543		ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
   544		if (!ctx)
   545			return ERR_PTR(-ENOMEM);
   546	
   547		cookie = fscache_acquire_cookie(volume, FSCACHE_ADV_WANT_CACHE_SIZE,
   548						name, strlen(name), NULL, 0, 0);
   549		if (!cookie) {
   550			erofs_err(sb, "failed to get cookie for %s", name);
   551			ret = -EINVAL;
   552			goto err;
   553		}
   554	
   555		fscache_use_cookie(cookie, false);
   556		ctx->cookie = cookie;
   557	
   558		if (need_inode) {
   559			struct inode *const inode = new_inode(sb);
   560	
   561			if (!inode) {
   562				erofs_err(sb, "failed to get anon inode for %s", name);
   563				ret = -ENOMEM;
   564				goto err_cookie;
   565			}
   566	
   567			set_nlink(inode, 1);
   568			inode->i_size = OFFSET_MAX;
   569			inode->i_mapping->a_ops = &erofs_fscache_meta_aops;
   570			mapping_set_gfp_mask(inode->i_mapping, GFP_NOFS);
   571	
   572			ctx->inode = inode;
   573		}
   574	
   575		return ctx;
   576	
   577	err_cookie:
   578		fscache_unuse_cookie(ctx->cookie, NULL, NULL);
   579		fscache_relinquish_cookie(ctx->cookie, false);
   580	err:
   581		kfree(ctx);
   582		return ERR_PTR(ret);
   583	}
   584	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
