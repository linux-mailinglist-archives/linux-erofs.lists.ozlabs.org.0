Return-Path: <linux-erofs+bounces-1063-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CA92B93FB8
	for <lists+linux-erofs@lfdr.de>; Tue, 23 Sep 2025 04:20:52 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cW3cK25XZz3cYN;
	Tue, 23 Sep 2025 12:20:49 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.13
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1758594049;
	cv=none; b=QAy8bq57yLDfadzRZtKpkIHoXxt5U8HP4GgzRD7XUfB/kyfugIoIZOJRnsUkFIpadoM1GFR473N5YqgDJvl8cnDS8p2TNorDmT+waoU7crYi+9p2dixi2mKSffcpdBbZL4l4IIn9HgjO/AA1gW8s1LET0fT6RRGbJt+wK1Gq01TU+CUVLdGWyW5MEXUCkcJ1YhpxP1U6Ff20GiM761O7dB8R1b17UZNp0fc0JuP1alUs8q/42NSzxn2w/E1luZ5pp7fweoGHz8JqoosQB4Hwb6a56tlQSJZ2So87UIRcxj2TW+UCEADNMjD8yoGhjGhkRiqnYFGrTPZ2WmFHHFFrHw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1758594049; c=relaxed/relaxed;
	bh=ltbylFxGwowtYtzfUb+YN+K2SmrxKfRwWAXJcG8r8n8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jcZARh8Su4KIWP9mfrzLOcEhp/6lsSntagVgiil5EYW0rzvlCmh+gjEC2lFLNxQoCN+0Uv6bYR03ej8JISs+GG19IgoZccLAB8nNCql8H8y6ImEKUaj+iYfvL3ymy4biiPdoaqd+dDzjcExXFbTuY/Ff6xkZVEBzQ6bmrknrKofibIMcz+CkivCFtEa6d6WX+v8I0Ja8Gqh/KAkZ6wyiL1ksRyjfXMF6xN9JNvS+Knum+NrGWoPx54SDILzAdEISA7odUA1SEsyWJv0otanXIohgAR4dga368EjSEyHFwVqASraTkW7iyVYRzzbtMBxP4/dwe3c6inhCDMyn2jhBqA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=h3HrUp5T; dkim-atps=neutral; spf=pass (client-ip=198.175.65.13; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=h3HrUp5T;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=198.175.65.13; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cW3cH5B2qz2yqq
	for <linux-erofs@lists.ozlabs.org>; Tue, 23 Sep 2025 12:20:47 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758594048; x=1790130048;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ppX3DTmVDiyyr1YGHONK8vTnmyN+WSZqP4NnFiZKc+M=;
  b=h3HrUp5TrmrBc2RmjtzJmVvsVO6AzsIj9dPxsYD4DXt96pHym+vnXB7Q
   QmhrjzQtweTm0VZwjLHmllHco7IHvTgo6r9zay5X0vKjygXpWZE/aK/j4
   ieg5qTHA3zj/yUt94R+KYpYSmCY+9L6kF593WJthJAVdWlvPwPThwJh4U
   m2PurtPMOx2xz03l/Xay312Crwtxuqg4Cnl06Bn6eUtBWd/uC5J1M8Xs4
   cHo3l9Iy2/msbAbBU4g/H+VIWAXDooxTZHtlJXitQbkn33+XrxU6w4nUb
   MGLv5ll+7bEa+gbn1gyXSpctIR31uHlLKl68rJ9PnN44nx6hKnQ4t9wjG
   w==;
X-CSE-ConnectionGUID: aBEcgWluTueQfTEA/rywww==
X-CSE-MsgGUID: 2kP5jUMcQQ+wgrhHP2u53Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11561"; a="71972508"
X-IronPort-AV: E=Sophos;i="6.18,286,1751266800"; 
   d="scan'208";a="71972508"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2025 19:20:45 -0700
X-CSE-ConnectionGUID: ynn7v8pBR7moPg6dTZZ77g==
X-CSE-MsgGUID: lIbWXvhuQTKl85MlpyWPAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,286,1751266800"; 
   d="scan'208";a="177080456"
Received: from lkp-server02.sh.intel.com (HELO 84c55410ccf6) ([10.239.97.151])
  by fmviesa009.fm.intel.com with ESMTP; 22 Sep 2025 19:20:42 -0700
Received: from kbuild by 84c55410ccf6 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v0se0-0002fR-0x;
	Tue, 23 Sep 2025 02:20:40 +0000
Date: Tue, 23 Sep 2025 10:20:22 +0800
From: kernel test robot <lkp@intel.com>
To: Chunhai Guo <guochunhai@vivo.com>, xiang@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, chao@kernel.org,
	zbestahu@gmail.com, jefflexu@linux.alibaba.com, dhavale@google.com,
	lihongbo22@huawei.com, linux-erofs@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, Chunhai Guo <guochunhai@vivo.com>
Subject: Re: [PATCH] erofs: add direct I/O support for compressed data
Message-ID: <202509231034.jXPbkvNB-lkp@intel.com>
References: <20250922124304.489419-1-guochunhai@vivo.com>
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
In-Reply-To: <20250922124304.489419-1-guochunhai@vivo.com>
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Hi Chunhai,

kernel test robot noticed the following build errors:

[auto build test ERROR on xiang-erofs/dev-test]
[also build test ERROR on xiang-erofs/dev xiang-erofs/fixes linus/master v6.17-rc7 next-20250922]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Chunhai-Guo/erofs-add-direct-I-O-support-for-compressed-data/20250922-204843
base:   https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git dev-test
patch link:    https://lore.kernel.org/r/20250922124304.489419-1-guochunhai%40vivo.com
patch subject: [PATCH] erofs: add direct I/O support for compressed data
config: i386-buildonly-randconfig-003-20250923 (https://download.01.org/0day-ci/archive/20250923/202509231034.jXPbkvNB-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250923/202509231034.jXPbkvNB-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509231034.jXPbkvNB-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "z_erofs_file_fops" [fs/erofs/erofs.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

