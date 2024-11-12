Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89FA19C5DF8
	for <lists+linux-erofs@lfdr.de>; Tue, 12 Nov 2024 17:58:54 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Xnt0r04xVz2yhD
	for <lists+linux-erofs@lfdr.de>; Wed, 13 Nov 2024 03:58:52 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.9
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1731430730;
	cv=none; b=hJGzWwGZQhP/UW1bGKSCE6cPCM11lHWSabffLY3ACtbk7KKjpgvcMP06pdz6RFz7kbaBdyJLXdF99Pn2ev7g2ewtFCrmwSB2pyy40UTvwlkM3YH4ArFm1Ps/W7hCOwPOW0foIywgL/c0lIAVH/n3wfgBn2kfCWNn4R2whT38607o/9rjpghXejLQFa2smclNHBWlWvOcl6TKVU7shcFaRKjwCZjumYUixJa6p12iXQUAusFo16wqL/pVn74/98/8VQ23Cyq47U58f2GgWh0iyC/SZtywAOJNSa4DEquPuBgd5VvF9fBOy5Tb4hzdSFKVJwo4jJvF2iZSexgzFNmsfg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1731430730; c=relaxed/relaxed;
	bh=w2ozDLMfUbk+kRfL9cKHAuEADVKlLAi1pFkFQoIMgfk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZDu8khAI1OVcEhiANff8bm0RSRCNNPigEb+x3PQ+adytqp5s6Xm9favydBE2GdFvsYS+bdEvDPA6eGI97kgZyHlE7IUZZSNGMoxf5D9yC0d0aSxFdmARMCAyt6fpH9WPA3znNRPS7nPhx0FFakclX8fx1V71cUj9Csz4GsekJ3NgSwekuFjYdnNVOXiZUyeYZamLNmdPCrMwxnLiCkg7CPa+HnmAoKGtT0WyDTtXRlpxVgazU8ypc1iMRIdrjQfmxPvsxMrw0JItSUC1/ZBarvZMHOfdzfzMw5D4dsHmvW/9Enjw6evdav4sKFNrLup2drtqWbOlSALlS3E+BiPG1g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=TR7qMkMx; dkim-atps=neutral; spf=pass (client-ip=192.198.163.9; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=TR7qMkMx;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.198.163.9; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Xnt0l0JPjz2yVZ
	for <linux-erofs@lists.ozlabs.org>; Wed, 13 Nov 2024 03:58:44 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731430727; x=1762966727;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=aeoydx0HLFHSStAdMKkZnSfEwsDzUEWxHMeOyr5IZs4=;
  b=TR7qMkMxxs3fSmKC/5KQtoX/iET8BwyY333JbI6h4yPS6OFSIIFJF+wB
   Rn0A3T8cxxK/NWlr7AwHJ2r/8bxDegvj+7ho9/TC7VYEPMmIr2MTVIDpj
   zsvaWc2RpZZPBdk3OLuDx5Dt7UP3pc++9g3MEFShxKHRPj32C8ua8P11A
   SB84poVeSu6nJlu6zriAv3+thsleLV6Bew2Pdyxn9+hJq/W0oqJZn/5tn
   VJ8QbKIyMVAMY5efeb8M+Jz8NScWjQ/reYW0i97Ip7UP7x1qhZ7h8EtYt
   VQdgyEb+whVNUSjwqQX3HOHuKKTvQpNlqz0b8jl9/J4on6Gc2aPQ44iLG
   Q==;
X-CSE-ConnectionGUID: ZjMx4pjJR2e8xzlwL3s8Ww==
X-CSE-MsgGUID: 4S71/fzDQ1u+PxJRm6XLug==
X-IronPort-AV: E=McAfee;i="6700,10204,11254"; a="41888161"
X-IronPort-AV: E=Sophos;i="6.12,148,1728975600"; 
   d="scan'208";a="41888161"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2024 08:58:40 -0800
X-CSE-ConnectionGUID: TTsunEUaTSiwLWuDYqCwdA==
X-CSE-MsgGUID: FpX1XzS+RM+WhOuJGDmlnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,148,1728975600"; 
   d="scan'208";a="91597022"
Received: from lkp-server01.sh.intel.com (HELO bcfed0da017c) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 12 Nov 2024 08:58:38 -0800
Received: from kbuild by bcfed0da017c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tAuDr-0001YD-1w;
	Tue, 12 Nov 2024 16:58:35 +0000
Date: Wed, 13 Nov 2024 00:57:44 +0800
From: kernel test robot <lkp@intel.com>
To: Chunhai Guo <guochunhai@vivo.com>, xiang@kernel.org
Subject: Re: [PATCH] erofs: add sysfs node to drop all compression-related
 caches
Message-ID: <202411130033.ZP2Akhk8-lkp@intel.com>
References: <20241112091403.586545-1-guochunhai@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241112091403.586545-1-guochunhai@vivo.com>
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

url:    https://github.com/intel-lab-lkp/linux/commits/Chunhai-Guo/erofs-add-sysfs-node-to-drop-all-compression-related-caches/20241112-170412
base:   https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git dev-test
patch link:    https://lore.kernel.org/r/20241112091403.586545-1-guochunhai%40vivo.com
patch subject: [PATCH] erofs: add sysfs node to drop all compression-related caches
config: i386-randconfig-003-20241112 (https://download.01.org/0day-ci/archive/20241113/202411130033.ZP2Akhk8-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241113/202411130033.ZP2Akhk8-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411130033.ZP2Akhk8-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from fs/erofs/sysfs.c:9:
   In file included from fs/erofs/internal.h:11:
   In file included from include/linux/dax.h:6:
   In file included from include/linux/mm.h:2213:
   include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     518 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
>> fs/erofs/sysfs.c:175:3: error: call to undeclared function 'z_erofs_shrink_scan'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     175 |                 z_erofs_shrink_scan(sbi, ~0UL);
         |                 ^
   1 warning and 1 error generated.


vim +/z_erofs_shrink_scan +175 fs/erofs/sysfs.c

   132	
   133	static ssize_t erofs_attr_store(struct kobject *kobj, struct attribute *attr,
   134							const char *buf, size_t len)
   135	{
   136		struct erofs_sb_info *sbi = container_of(kobj, struct erofs_sb_info,
   137							s_kobj);
   138		struct erofs_attr *a = container_of(attr, struct erofs_attr, attr);
   139		unsigned char *ptr = __struct_ptr(sbi, a->struct_type, a->offset);
   140		unsigned long t;
   141		int ret;
   142	
   143		switch (a->attr_id) {
   144		case attr_pointer_ui:
   145			if (!ptr)
   146				return 0;
   147			ret = kstrtoul(skip_spaces(buf), 0, &t);
   148			if (ret)
   149				return ret;
   150			if (t != (unsigned int)t)
   151				return -ERANGE;
   152	#ifdef CONFIG_EROFS_FS_ZIP
   153			if (!strcmp(a->attr.name, "sync_decompress") &&
   154			    (t > EROFS_SYNC_DECOMPRESS_FORCE_OFF))
   155				return -EINVAL;
   156	#endif
   157			*(unsigned int *)ptr = t;
   158			return len;
   159		case attr_pointer_bool:
   160			if (!ptr)
   161				return 0;
   162			ret = kstrtoul(skip_spaces(buf), 0, &t);
   163			if (ret)
   164				return ret;
   165			if (t != 0 && t != 1)
   166				return -EINVAL;
   167			*(bool *)ptr = !!t;
   168			return len;
   169		case attr_drop_caches:
   170			ret = kstrtoul(skip_spaces(buf), 0, &t);
   171			if (ret)
   172				return ret;
   173			if (t != 1)
   174				return -EINVAL;
 > 175			z_erofs_shrink_scan(sbi, ~0UL);
   176			return len;
   177		}
   178		return 0;
   179	}
   180	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
