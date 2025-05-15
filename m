Return-Path: <linux-erofs+bounces-321-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8900DAB7B1E
	for <lists+linux-erofs@lfdr.de>; Thu, 15 May 2025 03:45:57 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZyY2M6kBBz2y8p;
	Thu, 15 May 2025 11:45:47 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.12
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1747273547;
	cv=none; b=W72/yCIWxSwinC6yKqI9iyBoY/AlLwBnPmzqHitY5z6r/NzNAFdsela/n27iyoeGkLPVigFU5bqZ0KbfHirwhD8FOS8wwyi1SDOEFMZITLA/Sy6aN+s+kabAH4/xCY/p9acrz0tR84xlAa4Yl4D+5tovHDGjP7Q6WrCn4Z/xo57KJJRCjhu4v9GHcMk9mUgEENQy006V2xFJdez3d0rjthuV2f6bee33BtxA4exbsTdXcf8sf1xPxotqu0eXuBuZF4y+KbDMs/o5HaizyB5vmoEyVgwDW2Vwh5VQxjhM26zrrTEVYjG/S+OLxyvhHDi3BNJpnIYmIUvt/YzhU0bEXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1747273547; c=relaxed/relaxed;
	bh=A/y1YrpRQfKEPlr6g8ki2PeTXeKQt6VL7Nf0Wil9qsE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xe4kNZ7oPIVSrIz/WdT4gb/qY5NnZeTczT9f3lpOGcPkcbRFLL1uDdzzK6PFh3OKSmLsc9fE31OAoSyldBiesZOdF51twMhf6Iw2JjxFGQgvwOK3+JCyWI2RJqi2Gjtv4DD4+O9Q/oJSAJqJ39WfLb2qfN8cSGwf8/yiYxpsgCEbnoRIy041rLYSmj7/6nxlmM93I0V4I++LBJ1W5G8N5GBflbHQ3ijP79Yk2T27ctG5Gdb3ZhV1Wq3BkLtb7jszHQze3oBdq0REN2Zh+xnzEnFbgbDFdJC0ic1pRvotgIU0TK9BLt/gxRydCN8dBYVdWbqiQLACMIYlO1r5KWbZsg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=FEuFytg0; dkim-atps=neutral; spf=pass (client-ip=192.198.163.12; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=FEuFytg0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.198.163.12; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZyY2K3SLKz2xRv
	for <linux-erofs@lists.ozlabs.org>; Thu, 15 May 2025 11:45:43 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747273546; x=1778809546;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mTAKBvruWSGs27qAdgmHzaFXS4fWhPHgKmMkrAWa7Ag=;
  b=FEuFytg092o2D7/Z7TxkxLje3kWom2NSppqLYV9pNnCEichjBibmIabI
   mDo6IiQAVRX4kmSP6J2c+NbwIem3ALQcu/p1ScypdTMxNgF0xWcDhhctJ
   dOgJBLy97ro+pRurIqGXnv4CobYV7ZmnXjnHDY9puR4eavJxQHrME4Si7
   t+Bu6jHstNrdd5aTe+7J9g49Z3Y7v8d2btVwx3BE5//WdHd0mJn25Zh8J
   CbrjCT1ewm8loku2EhE1QdSvHSkTc+luLdfohPrkgRX6VS6MnvrPnUQDN
   jO0rt5P4Iqur3z1ixy9RwQ69xS4EkDqfG38FC/025keteKB7U/tS/AAqy
   Q==;
X-CSE-ConnectionGUID: OS5CoORiTDGo3k5AlWLHvA==
X-CSE-MsgGUID: nrjLfrDkTtSWoSx2PSD9nA==
X-IronPort-AV: E=McAfee;i="6700,10204,11433"; a="52998943"
X-IronPort-AV: E=Sophos;i="6.15,289,1739865600"; 
   d="scan'208";a="52998943"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2025 18:45:41 -0700
X-CSE-ConnectionGUID: f0L1mMBEQzKurhLdRDS4Gg==
X-CSE-MsgGUID: xdbFWmHESU+T4Io5HL7DAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,289,1739865600"; 
   d="scan'208";a="137945612"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 14 May 2025 18:45:39 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uFNfE-000HmB-2o;
	Thu, 15 May 2025 01:45:36 +0000
Date: Thu, 15 May 2025 09:44:38 +0800
From: kernel test robot <lkp@intel.com>
To: Bo Liu <liubo03@inspur.com>, xiang@kernel.org, chao@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, linux-erofs@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, Bo Liu <liubo03@inspur.com>
Subject: Re: [PATCH v2] erofs: support deflate decompress by using Intel QAT
Message-ID: <202505150946.oGwqIzrW-lkp@intel.com>
References: <20250514121709.2557-1-liubo03@inspur.com>
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250514121709.2557-1-liubo03@inspur.com>
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Hi Bo,

kernel test robot noticed the following build warnings:

[auto build test WARNING on xiang-erofs/dev-test]
[also build test WARNING on xiang-erofs/dev xiang-erofs/fixes linus/master v6.15-rc6 next-20250514]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Bo-Liu/erofs-support-deflate-decompress-by-using-Intel-QAT/20250514-202351
base:   https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git dev-test
patch link:    https://lore.kernel.org/r/20250514121709.2557-1-liubo03%40inspur.com
patch subject: [PATCH v2] erofs: support deflate decompress by using Intel QAT
config: riscv-randconfig-002-20250515 (https://download.01.org/0day-ci/archive/20250515/202505150946.oGwqIzrW-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250515/202505150946.oGwqIzrW-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505150946.oGwqIzrW-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> fs/erofs/decompressor_crypto.c:211:9: warning: braces around scalar initializer
     211 |         [Z_EROFS_COMPRESSION_DEFLATE] = {&(struct z_erofs_crypto_engine) {
         |         ^
   fs/erofs/decompressor_crypto.c:211:9: note: (near initialization for 'z_erofs_crypto[2]')
   fs/erofs/decompressor_crypto.c:216:17: warning: excess elements in scalar initializer
     216 |                 &(const struct z_erofs_crypto_engine) { NULL },
         |                 ^
   fs/erofs/decompressor_crypto.c:216:17: note: (near initialization for 'z_erofs_crypto[2]')


vim +211 fs/erofs/decompressor_crypto.c

   207	
   208	struct z_erofs_crypto_engine *z_erofs_crypto[] = {
   209		[Z_EROFS_COMPRESSION_LZ4] = &(struct z_erofs_crypto_engine) {NULL},
   210		[Z_EROFS_COMPRESSION_LZMA] = &(struct z_erofs_crypto_engine) {NULL},
 > 211		[Z_EROFS_COMPRESSION_DEFLATE] = {&(struct z_erofs_crypto_engine) {

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

