Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B7F89C5442
	for <lists+linux-erofs@lfdr.de>; Tue, 12 Nov 2024 11:39:37 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XnjbC0jWgz2yZN
	for <lists+linux-erofs@lfdr.de>; Tue, 12 Nov 2024 21:39:35 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.12
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1731407973;
	cv=none; b=lrgvU+Lu5j3WseHS+z48FhiPsW0yCXLCT2QSsGCMAHMGs/kHg1VZnW3aO79a3slJtIFGe5zabVGOUAB/ZnMHOoLyKI/bjCociRLD1knlrfaSR5Fw2VeLEPv+xy5CcL8RBJ8sOlMvqXg8nTCLC8gBZDRM5HdrWc49qQTT75Zp3cyEteqAbsJvTg0elmUABd0iJ32mR4E33PA2e1LyKywfsFMZmjq34TdUtohntfYyiRZmiUWvKQICk7YIJNGSeLeiZMdGD83p1v2+4DoFgvZnjgOsSQ5Wz5L3LFcYwDg+3fDXRW1uxwgQqAUdgUjr7e63QF7KtcIARXODj9A4DobsXA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1731407973; c=relaxed/relaxed;
	bh=QQrW5g5XsRZZ5TvXrdOfNPmb413oG5ISg4eqzmk82l0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ADpyfAdF0RbdMgInlOBdoXl/b45XnVhy3xBwHJM4ArAvxrPl16NukWFRrV6gqmVS9ThzY0Fv11Y85UWDQ/ShNFfeAVGS/qhP1hJbgEBgtGIWRScp1bVG+x9xfLtKv9juEXSOYl3XQB+TeM2AYN7yw0poQM0xBZZp9JiV1ONRKMtRZHcKyvi1vw/Y54vv9LTGlpZYw+Bw+6dT69gOoYAtc2OsDfAUsbxFWLXM+9u8htJJY6DdIShDNumA3wi4qHrT38G0f6dd5wcd9qeBTOApkOEKr486SmoGKMDmkVq8R27qprD22/b2vu5KXIyEEa+uI0osz8/fyB2At3OMMlFRiw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=hwqNkfCE; dkim-atps=neutral; spf=pass (client-ip=198.175.65.12; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=hwqNkfCE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=198.175.65.12; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Xnjb62YDCz2xxr
	for <linux-erofs@lists.ozlabs.org>; Tue, 12 Nov 2024 21:39:27 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731407971; x=1762943971;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TnIiOnF1wqFWtB0GnZGUgThTMXjgr7lgvOJgh9Y2oHg=;
  b=hwqNkfCEFEnVmOZzWuXMEpJzIbJTcjtp0ZNshoRjcEJjyANnDkCmk0qX
   aLXZx6s5cTwoFvQ71e0M8KgkPf466f+F84Csq/ntVTyZIycdUFLOlLR2D
   3+ZHfv2X+oQMMrNrKAtJkPhCg1PgFYv63A0VLOK+q6AMgZiCjsVwyQn3R
   Oh7otJrs/ZHZ1CGqC8TYGKknECf3QTIp0e34mlcwaOYNEihVxnyn+g5jA
   EWry/f5rF3vdXpdARzkZuEjUaw9+P0GWmGPTNwxAZGWRtURuvsEZW5UEZ
   74XJSgG2PlZuWvV3WjWsr7YLgzrimNMROd+5peNabzcPHMtqbtheV/lq9
   w==;
X-CSE-ConnectionGUID: MUzcPWG6QCWYaZkHHK+tYA==
X-CSE-MsgGUID: ur1NnfDfRUi/m8VMHbNtvw==
X-IronPort-AV: E=McAfee;i="6700,10204,11253"; a="42638700"
X-IronPort-AV: E=Sophos;i="6.12,147,1728975600"; 
   d="scan'208";a="42638700"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2024 02:39:26 -0800
X-CSE-ConnectionGUID: GOV0UJudRiCoMrOT7nhCSg==
X-CSE-MsgGUID: l9tSmif+Q7StVA/pjNrGTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,147,1728975600"; 
   d="scan'208";a="91412084"
Received: from lkp-server01.sh.intel.com (HELO bcfed0da017c) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 12 Nov 2024 02:39:22 -0800
Received: from kbuild by bcfed0da017c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tAoIq-0000tx-1t;
	Tue, 12 Nov 2024 10:39:20 +0000
Date: Tue, 12 Nov 2024 18:39:10 +0800
From: kernel test robot <lkp@intel.com>
To: Chunhai Guo <guochunhai@vivo.com>, xiang@kernel.org
Subject: Re: [PATCH] erofs: clean up the cache if cached decompression is
 disabled
Message-ID: <202411121801.vd2yHEHx-lkp@intel.com>
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
Cc: linux-kernel@vger.kernel.org, huyue2@coolpad.com, oe-kbuild-all@lists.linux.dev, linux-erofs@lists.ozlabs.org
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
config: x86_64-randconfig-161-20241112 (https://download.01.org/0day-ci/archive/20241112/202411121801.vd2yHEHx-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241112/202411121801.vd2yHEHx-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411121801.vd2yHEHx-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/seq_file.h:9,
                    from fs/erofs/super.c:8:
   fs/erofs/super.c: In function 'erofs_fc_reconfigure':
>> fs/erofs/super.c:749:32: error: 'struct erofs_sb_info' has no member named 'umount_mutex'
     749 |                 mutex_lock(&sbi->umount_mutex);
         |                                ^~
   include/linux/mutex.h:166:44: note: in definition of macro 'mutex_lock'
     166 | #define mutex_lock(lock) mutex_lock_nested(lock, 0)
         |                                            ^~~~
>> fs/erofs/super.c:750:17: error: implicit declaration of function 'z_erofs_shrink_scan' [-Werror=implicit-function-declaration]
     750 |                 z_erofs_shrink_scan(sbi, ~0UL);
         |                 ^~~~~~~~~~~~~~~~~~~
   fs/erofs/super.c:751:34: error: 'struct erofs_sb_info' has no member named 'umount_mutex'
     751 |                 mutex_unlock(&sbi->umount_mutex);
         |                                  ^~
   cc1: some warnings being treated as errors


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
