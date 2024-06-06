Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 1846F8FF68F
	for <lists+linux-erofs@lfdr.de>; Thu,  6 Jun 2024 23:17:47 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=naUtwz1+;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VwHGw1F0bz3fsX
	for <lists+linux-erofs@lfdr.de>; Fri,  7 Jun 2024 07:17:44 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=naUtwz1+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=198.175.65.12; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VwHGm5Gcfz3fqC
	for <linux-erofs@lists.ozlabs.org>; Fri,  7 Jun 2024 07:17:34 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717708658; x=1749244658;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=N0Q7oD6FKmO32Pc1pIntTHg0BQLLkxWsDSJc6HB1PFs=;
  b=naUtwz1+/2VbC23rL1CnwoUOQpvycnF/uak3rSTaPU6GTeu2SjUNR6Jt
   sVDD3c9DvJ/Bh8WZHT8LffVHGL3jPg79lB/Eh2RwhvRQ3gXhqdktAiK/e
   w5oLbG/ZdktvmGZuTGoRL5kNCKhfB1tylzM+xtvbh3PCaLXOz1Wv28Mzp
   kJ0BgvsJyP/1s2bRZH50/UNCG03VjiY65Hc6OybD6wmSJKo7Oc9afPY3p
   rzMrPiDwA84djM8JSxoVk1uCelkHYdHH2kaHDrK1egoYCH/pmYXWC6D86
   5fvYWJ+/RkEw6+WGSaJ3SzRE9WNEedwHozjeN0pW58NohFCVGX6HGL5wB
   Q==;
X-CSE-ConnectionGUID: t4vF7hC2TGOoNndLXlToQw==
X-CSE-MsgGUID: SK1o1b8MT2eQ2dsEGkwPVQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11095"; a="25814973"
X-IronPort-AV: E=Sophos;i="6.08,219,1712646000"; 
   d="scan'208";a="25814973"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2024 14:17:32 -0700
X-CSE-ConnectionGUID: /3VKxS5mSyGw3G6NuzDeGQ==
X-CSE-MsgGUID: OY8x7gTDTFG2XlxKbELLIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,219,1712646000"; 
   d="scan'208";a="75576778"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 06 Jun 2024 14:17:29 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sFKUA-0003jO-2m;
	Thu, 06 Jun 2024 21:17:26 +0000
Date: Fri, 7 Jun 2024 05:16:50 +0800
From: kernel test robot <lkp@intel.com>
To: Tao Zeng via B4 Relay <devnull+tao.zeng.amlogic.com@kernel.org>,
	Gao Xiang <xiang@kernel.org>, Chao Yu <yuchao0@huawei.com>,
	Chao Yu <chao@kernel.org>, Yue Hu <huyue2@coolpad.com>,
	Jeffle Xu <jefflexu@linux.alibaba.com>,
	Sandeep Dhavale <dhavale@google.com>
Subject: Re: [PATCH] erofs: support external crypto for decompression
Message-ID: <202406070429.UJRJ6zGg-lkp@intel.com>
References: <20240606-erofs-decompression-v1-1-ec5f31396e04@amlogic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240606-erofs-decompression-v1-1-ec5f31396e04@amlogic.com>
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
Cc: Tao Zeng <tao.zeng@amlogic.com>, linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Tao,

kernel test robot noticed the following build errors:

[auto build test ERROR on ee78a17615ad0cfdbbc27182b1047cd36c9d4d5f]

url:    https://github.com/intel-lab-lkp/linux/commits/Tao-Zeng-via-B4-Relay/erofs-support-external-crypto-for-decompression/20240606-155702
base:   ee78a17615ad0cfdbbc27182b1047cd36c9d4d5f
patch link:    https://lore.kernel.org/r/20240606-erofs-decompression-v1-1-ec5f31396e04%40amlogic.com
patch subject: [PATCH] erofs: support external crypto for decompression
config: m68k-defconfig (https://download.01.org/0day-ci/archive/20240607/202406070429.UJRJ6zGg-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240607/202406070429.UJRJ6zGg-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406070429.UJRJ6zGg-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   In file included from fs/erofs/decompressor.c:6:
>> fs/erofs/compress.h:120:1: error: expected identifier or '(' before '{' token
     120 | {
         | ^
>> fs/erofs/compress.h:116:19: warning: 'z_erofs_load_crypto_config' declared 'static' but never defined [-Wunused-function]
     116 | static inline int z_erofs_load_crypto_config(struct super_block *sb,
         |                   ^~~~~~~~~~~~~~~~~~~~~~~~~~


vim +120 fs/erofs/compress.h

   115	
 > 116	static inline int z_erofs_load_crypto_config(struct super_block *sb,
   117						     struct erofs_super_block *dsb,
   118						     void *data,
   119						     int size);
 > 120	{
   121		if (crypto) {
   122			erofs_err(sb, "crypto algorithm isn't enabled");
   123			return -EINVAL;
   124		}
   125		return 0;
   126	}
   127	#endif
   128	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
