Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B2569C56DB
	for <lists+linux-erofs@lfdr.de>; Tue, 12 Nov 2024 12:44:08 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Xnl1W1td2z2yb9
	for <lists+linux-erofs@lfdr.de>; Tue, 12 Nov 2024 22:43:59 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.15
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1731411837;
	cv=none; b=I9ns+Nvm+XJ6ie/My+2jt5QvhwdQIH/mBKLiCgxASe5+xqmgvt9I5D/zuOrI/8ZeQpH64sDTLDMQrtA89YNwEemFhbKT+mUw3IWKxLKrYV5USrE0d2IGYlcVO+0ShROjqCSDxhEsJDVPsiN3PCxpDUrKYPFsZ3kPeJfwLD42Mhg3laMpmUlIxyOn8n7/8UAcECsJtTih8MqcQnkB4LHfJkwWTlX3CuFsGJAUSil2UQ/YHwbU0yVJtWGgvb/4k1ijM1WHVxgbL8z26HRT7bXDHZ8TZTLrh9ayGy8Ufm7oYRbDAWIVLFY1Ff3fZbhLsIGd1S8FcJYl92NddVYIB9s0Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1731411837; c=relaxed/relaxed;
	bh=DvmadZv1fqmu7a0RI2zmb1+gvrKjNAjTtwa+fchuRwo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gAiyZQwXeI6GIB6KPFbhX2Gts6/vS8VovrsUs+IvoJdHc3SiVxlHw4OR7RAMrTbGhHjy7wGD/UC5FvFFcmozDZJc6b3TeFKIutLd4lmUgmR3eshtSL6lXJRJ7mLrUhuGjAzB5vU1qkq4ca5SXydIkMFGT1jHaS7oiCpXZe+Ozdv8xcKt4tr+Xu+LvxrDLFl4EppNWmy1znolTCft8qPw19zwI16751g1BpJJkpyIqpVRu706gZC2eSnvYXvH4Gx1FySyxnTInU5CyDMiT+cw0gXy7X1qznqetIV5V930PcrwROCGQSTwj+m9bUBTzVVKZ0iZI+7Yoy9t8XOiCeMYOA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=FW7VMG9F; dkim-atps=neutral; spf=pass (client-ip=198.175.65.15; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=FW7VMG9F;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=198.175.65.15; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Xnl1Q6LrFz2xxr
	for <linux-erofs@lists.ozlabs.org>; Tue, 12 Nov 2024 22:43:51 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731411836; x=1762947836;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PO4EqrQG8RsV0jjl15L5FZ6DGDHaLJ4T2Tt9UahcMr0=;
  b=FW7VMG9FczHDDxeqmTM/6d82NrQfR1qliwHmcLNdd84YGJtwBRQm4t0E
   pm+u8j4CmnDPPRAswUffDxs7Sfb0Cs7YQTScGqLnKY17odTwamrtuw9se
   rp0AILb/GHXuokWIiqRfkwzvB7TNZfvMsdyU5evN/uZZNQYVJ+dwZuUxS
   Im77SoxcLVuiJMYaRVdAOdCC5z/pqSc9ldlLNXpToD/LyhTVsKneSWPj3
   tSji9nZyOA6Xiaga8JLJkJdJ+yaLlVgT+4DHKB3eSd02EPQRVGg9Pa5Xa
   h+JpHlzAChgDf09IXe5zz1w2JakNEsK2vTErQ6VB08Yf1YPvDMG5N1FUK
   A==;
X-CSE-ConnectionGUID: T1ua+DOfQpuIXye9bA2JRA==
X-CSE-MsgGUID: cbUk3SHSROabKHhU55ro9Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="34943598"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="34943598"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2024 03:43:48 -0800
X-CSE-ConnectionGUID: JRXgTNxdSRqQi1bW9R5BFg==
X-CSE-MsgGUID: 93AprrR1TuSu8jYshNm7mg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,147,1728975600"; 
   d="scan'208";a="110705762"
Received: from lkp-server01.sh.intel.com (HELO bcfed0da017c) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 12 Nov 2024 03:43:45 -0800
Received: from kbuild by bcfed0da017c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tApJ8-0001Ev-1f;
	Tue, 12 Nov 2024 11:43:42 +0000
Date: Tue, 12 Nov 2024 19:42:55 +0800
From: kernel test robot <lkp@intel.com>
To: Chunhai Guo <guochunhai@vivo.com>, xiang@kernel.org
Subject: Re: [PATCH] erofs: clean up the cache if cached decompression is
 disabled
Message-ID: <202411121928.BzWJRXSl-lkp@intel.com>
References: <20241112031513.528474-1-guochunhai@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241112031513.528474-1-guochunhai@vivo.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_PASS autolearn=disabled version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org
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
Cc: llvm@lists.linux.dev, linux-kernel@vger.kernel.org, huyue2@coolpad.com, oe-kbuild-all@lists.linux.dev, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Chunhai,

kernel test robot noticed the following build errors:

[auto build test ERROR on xiang-erofs/dev-test]
[also build test ERROR on xiang-erofs/dev xiang-erofs/fixes linus/master v6.12-rc7 next-20241112]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Chunhai-Guo/erofs-clean-up-the-cache-if-cached-decompression-is-disabled/20241112-105927
base:   https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git dev-test
patch link:    https://lore.kernel.org/r/20241112031513.528474-1-guochunhai%40vivo.com
patch subject: [PATCH] erofs: clean up the cache if cached decompression is disabled
config: x86_64-randconfig-004-20241112 (https://download.01.org/0day-ci/archive/20241112/202411121928.BzWJRXSl-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241112/202411121928.BzWJRXSl-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411121928.BzWJRXSl-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from fs/erofs/super.c:10:
   In file included from include/linux/fs_context.h:14:
   In file included from include/linux/security.h:33:
   In file included from include/linux/mm.h:2213:
   include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     518 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
>> fs/erofs/super.c:749:20: error: no member named 'umount_mutex' in 'struct erofs_sb_info'
     749 |                 mutex_lock(&sbi->umount_mutex);
         |                             ~~~  ^
   include/linux/mutex.h:166:44: note: expanded from macro 'mutex_lock'
     166 | #define mutex_lock(lock) mutex_lock_nested(lock, 0)
         |                                            ^~~~
>> fs/erofs/super.c:750:3: error: call to undeclared function 'z_erofs_shrink_scan'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     750 |                 z_erofs_shrink_scan(sbi, ~0UL);
         |                 ^
   fs/erofs/super.c:751:22: error: no member named 'umount_mutex' in 'struct erofs_sb_info'
     751 |                 mutex_unlock(&sbi->umount_mutex);
         |                               ~~~  ^
   1 warning and 3 errors generated.


vim +749 fs/erofs/super.c

   731	
   732	static int erofs_fc_reconfigure(struct fs_context *fc)
   733	{
   734		struct super_block *sb = fc->root->d_sb;
   735		struct erofs_sb_info *sbi = EROFS_SB(sb);
   736		struct erofs_sb_info *new_sbi = fc->s_fs_info;
   737	
   738		DBG_BUGON(!sb_rdonly(sb));
   739	
   740		if (new_sbi->fsid || new_sbi->domain_id)
   741			erofs_info(sb, "ignoring reconfiguration for fsid|domain_id.");
   742	
   743		if (test_opt(&new_sbi->opt, POSIX_ACL))
   744			fc->sb_flags |= SB_POSIXACL;
   745		else
   746			fc->sb_flags &= ~SB_POSIXACL;
   747	
   748		if (new_sbi->opt.cache_strategy == EROFS_ZIP_CACHE_DISABLED) {
 > 749			mutex_lock(&sbi->umount_mutex);
 > 750			z_erofs_shrink_scan(sbi, ~0UL);
   751			mutex_unlock(&sbi->umount_mutex);
   752		}
   753		sbi->opt = new_sbi->opt;
   754	
   755		fc->sb_flags |= SB_RDONLY;
   756		return 0;
   757	}
   758	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
