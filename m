Return-Path: <linux-erofs+bounces-195-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 48019A855B7
	for <lists+linux-erofs@lfdr.de>; Fri, 11 Apr 2025 09:45:19 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZYpcH16l4z3c5N;
	Fri, 11 Apr 2025 17:44:47 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.14
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1744357487;
	cv=none; b=URkc6L/yrydJ/5DFu0wPKt8n2ZjEVeO/dFNx5FafmG6MwHbpgo98cAkIWvZWeeTYnWuEcZ5K1mbT7R+cSfgXQOzwFJuwzcwguOQN4SLPgb1H0H/TsU/0PXDUcoa0M8VA6+bkZCaOEYwZEAy6CBGtJPwM2AKryGl//MsTMDmJN1pwzmclhReQANOCNA7H2bmpwFn81wy+YT+/H4ZpGpX0u43kuBYXUp6WDMz51/DiSppic/t/JWPDQyQUM500S623OuTXKUuOnvcDT0mACHOMvUYgGltPmtaI8G7SnkltfTrzwucPtrGj3xUnGsbiez9qqCtFqJQ9jPH1HIIE1qGl+A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1744357487; c=relaxed/relaxed;
	bh=AZo9EMKWJYXi3pMZawuNQq0YSXGKAQJeUVVpovoAsy0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LdHusrSuXSr34SYemvkxzSTIZCjaXehpV7moAA5YPlxBlQQ+mh48E8cvPONK6NFu8w9AWzjyd0i4hev71oDxLIixjZKb8BD2Jw6w5jXjdcutMGuGPyJG3SswNuJwfl03sZ/RUGPEZczfzHlhipnOugUx69bn4CksIzMt3kiPspEKMB9eDi/UsxtdIXTBWqqwYO8cSIhNw3J/yudZFNj4haDKCnWuWbUCskASJR0+uWpVNTKEmScfXv2xrUTr7/5PmeCNBi1CuN1Yyf3ZYyvwxGx4rV/TXwgWgqNlk6lRZPIUBxvODmheKlXCOkxb9hzoRnyfzfL7q65D0/1aSIrAUg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=IWSVGd8O; dkim-atps=neutral; spf=pass (client-ip=192.198.163.14; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=IWSVGd8O;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.198.163.14; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZYpcG09BFz3c2G
	for <linux-erofs@lists.ozlabs.org>; Fri, 11 Apr 2025 17:44:45 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744357486; x=1775893486;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BatrTrRZ7JbnzpwmHwqLBJA+VfyF2JrypX+7zybZCtk=;
  b=IWSVGd8Oeq+R51ltW3il5blLh9K/9VAnI0sS9OfMjPEU65Ix/6Qm1DJI
   rgN6p11vg8TFo0Gyp8l1Jx9PNM3QShzCFprF1au9W1g4kD/Z/XRIzY75e
   BruqZm40sNm2359rbbtWJOoQk69bu+YwleZCcWXCnbwbkJCDjJmIc8Fq7
   gl/urhmgzScYRb1wwAH2V7hCIGXgO9I/UJqvEPxkSLjCfNuXb/r3uFOJq
   BK9pFoCXvIDuFkHiKF86iW7tmUZKL9xcmPiZnr5aX/cNIe1RiwUzwJJ6m
   mX2x65ZQ3xHsbB+K+l4KAvdUmI2xGQqR0hhB2qXcrF165CnRgXFWvRZ+M
   w==;
X-CSE-ConnectionGUID: Ts2y4u6iT2uWgXBCrZwG9A==
X-CSE-MsgGUID: uDE0xtezRQCwIEJHdz9S0A==
X-IronPort-AV: E=McAfee;i="6700,10204,11400"; a="46067874"
X-IronPort-AV: E=Sophos;i="6.15,203,1739865600"; 
   d="scan'208";a="46067874"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2025 00:44:44 -0700
X-CSE-ConnectionGUID: yco92PoOR6OZAG9251mptA==
X-CSE-MsgGUID: YPEP/conRxqdoCsd2q8WeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,203,1739865600"; 
   d="scan'208";a="133230360"
Received: from lkp-server01.sh.intel.com (HELO b207828170a5) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 11 Apr 2025 00:44:42 -0700
Received: from kbuild by b207828170a5 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1u3944-000Aws-0L;
	Fri, 11 Apr 2025 07:44:40 +0000
Date: Fri, 11 Apr 2025 15:44:08 +0800
From: kernel test robot <lkp@intel.com>
To: Bo Liu <liubo03@inspur.com>, xiang@kernel.org, chao@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	Bo Liu <liubo03@inspur.com>
Subject: Re: [PATCH 2/2] erofs: support deflate decompress by using Intel QAT
Message-ID: <202504111545.9ZYfP6Gr-lkp@intel.com>
References: <20250410042048.3044-3-liubo03@inspur.com>
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250410042048.3044-3-liubo03@inspur.com>
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Hi Bo,

kernel test robot noticed the following build errors:

[auto build test ERROR on xiang-erofs/dev-test]
[also build test ERROR on xiang-erofs/dev linus/master v6.15-rc1]
[cannot apply to xiang-erofs/fixes next-20250411]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Bo-Liu/erofs-remove-duplicate-code/20250410-122442
base:   https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git dev-test
patch link:    https://lore.kernel.org/r/20250410042048.3044-3-liubo03%40inspur.com
patch subject: [PATCH 2/2] erofs: support deflate decompress by using Intel QAT
config: x86_64-buildonly-randconfig-003-20250411 (https://download.01.org/0day-ci/archive/20250411/202504111545.9ZYfP6Gr-lkp@intel.com/config)
compiler: clang version 20.1.2 (https://github.com/llvm/llvm-project 58df0ef89dd64126512e4ee27b4ac3fd8ddf6247)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250411/202504111545.9ZYfP6Gr-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202504111545.9ZYfP6Gr-lkp@intel.com/

All errors (new ones prefixed by >>):

>> fs/erofs/sysfs.c:136:12: error: no member named 'erofs_tfm' in 'struct erofs_sb_info'
     136 |                 if (sbi->erofs_tfm)
         |                     ~~~  ^
   fs/erofs/sysfs.c:138:33: error: no member named 'erofs_tfm' in 'struct erofs_sb_info'
     138 |                                 crypto_comp_alg_common(sbi->erofs_tfm)->base.cra_driver_name);
         |                                                        ~~~  ^
   2 errors generated.


vim +136 fs/erofs/sysfs.c

   115	
   116	static ssize_t erofs_attr_show(struct kobject *kobj,
   117					struct attribute *attr, char *buf)
   118	{
   119		struct erofs_sb_info *sbi = container_of(kobj, struct erofs_sb_info,
   120							s_kobj);
   121		struct erofs_attr *a = container_of(attr, struct erofs_attr, attr);
   122		unsigned char *ptr = __struct_ptr(sbi, a->struct_type, a->offset);
   123	
   124		switch (a->attr_id) {
   125		case attr_feature:
   126			return sysfs_emit(buf, "supported\n");
   127		case attr_pointer_ui:
   128			if (!ptr)
   129				return 0;
   130			return sysfs_emit(buf, "%u\n", *(unsigned int *)ptr);
   131		case attr_pointer_bool:
   132			if (!ptr)
   133				return 0;
   134			return sysfs_emit(buf, "%d\n", *(bool *)ptr);
   135		case attr_comp_crypto:
 > 136			if (sbi->erofs_tfm)
   137				return sysfs_emit(buf, "%s\n",
   138					crypto_comp_alg_common(sbi->erofs_tfm)->base.cra_driver_name);
   139			else
   140				return sysfs_emit(buf, "NONE\n");
   141		}
   142		return 0;
   143	}
   144	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

