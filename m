Return-Path: <linux-erofs+bounces-1066-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E3FBB9402D
	for <lists+linux-erofs@lfdr.de>; Tue, 23 Sep 2025 04:33:07 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cW3tS5sW9z3cYN;
	Tue, 23 Sep 2025 12:33:04 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.7
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1758594784;
	cv=none; b=KHg5YbU66rz+D9oSRkmS7mRBXj1FWbp7HVwPrutR8cPfxdiUmm9scfJKA1r48VKQpgrIqATuXcl4YfROpE4dfxch8ZXSN63+PCn39DAtbbCPpieJIz6t3rNwzZSnxlXQAQ66ZAQrCC7Ufy7XDMMXaTNO0TcBb3RLIeMitEeFi5zLLcDhDfaEoTB0IskoimJXwjKInppuSe9Lf8j1CJR/owVzYJ7iQSuE1Cy5u4nqqCbVhM6VgVAKDMzQiIIN4XdjlwckrBW8A6TG4Ah5yTLCEvVDUGdiFcOE0IFNp5sUM1lOOAHUi+CEu7xQJypqclyGCIYCDfuZMauCenKs2HPFHg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1758594784; c=relaxed/relaxed;
	bh=fyh7NTOyz0GoV8ftZQpvJYBlLX7SOFqE/dQwwgPnY0U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cawZB5hGocJh7hVBPyI+LnWFGezJj4xMvLdZ5P7QNRGWefnhlzC81PttZX8Odg+0xSE4iiXBbDXMGL62IZTFHwUefTswx83XfAI64QAq72MUlDken9ObqfqpWEUXJcLyfHOmXa0V36zDjIubIZI6be4EwKU8HkyWgrSbCZo9KbxnjK2KRug9PzoKK2iv+0u1iiGOCDdqk8N4pIRe/qVjkUO5/ZCXQokdi3JIJZ2L5nmaW1s7zrgYguyqi58XUH1VSsOXEebcnoA4BsuZpBpcV3P9Ayc4y9qXQWvtb6EPq8BRWwvbNklOiL+Wg011aKUiWd2cEF2BeI4p9cemJ1TLgw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=i4sbw9vr; dkim-atps=neutral; spf=pass (client-ip=192.198.163.7; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=i4sbw9vr;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.198.163.7; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cW3tQ3SnHz2yqq
	for <linux-erofs@lists.ozlabs.org>; Tue, 23 Sep 2025 12:32:50 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758594783; x=1790130783;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=s6xE7TdEQAnRwaTxux4s/PGfcxwqJAxkDLccQUgUC3s=;
  b=i4sbw9vrEPgnTSMt2cm8ReTkI2Dg46z0tCbmWk30NLGojomwm9R38vho
   b9nRo69SLfcSDSGZ+MmWlmKrVieuQLi5u0yntEFg02CSY8OSrTbMsVlT/
   puTJmWi3kzganas17sdomeihF2Rklm1eml1KB2UGiKqFKkvwmWPFgBbIQ
   G2z14zJU0EElzeAclQ5vt9YsqjJjKJyMac3yS7+cQCk2KddNtMfFzIlE9
   1RhEpAyAGhYw1RryOukZKZ4p2bbVQx7c5WCxeICMFVMNmk1tk1bPe8N6x
   H8rjhHY184xVC7yH99DZ+cVIKKWcowW6i9KOmyonN/nNbENj37UWspqtE
   g==;
X-CSE-ConnectionGUID: 4kDkf3UqRgugu1E8kl64Pg==
X-CSE-MsgGUID: nzMM7Lp0SOWi+yG3KKskeg==
X-IronPort-AV: E=McAfee;i="6800,10657,11561"; a="86303374"
X-IronPort-AV: E=Sophos;i="6.18,286,1751266800"; 
   d="scan'208";a="86303374"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2025 19:32:48 -0700
X-CSE-ConnectionGUID: nZ5wvhotQ66/ujLtceuvMw==
X-CSE-MsgGUID: MLzt1+KRTpyAz8r4CNGICQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,286,1751266800"; 
   d="scan'208";a="175919634"
Received: from lkp-server02.sh.intel.com (HELO 84c55410ccf6) ([10.239.97.151])
  by orviesa010.jf.intel.com with ESMTP; 22 Sep 2025 19:32:44 -0700
Received: from kbuild by 84c55410ccf6 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v0spd-0002g7-0u;
	Tue, 23 Sep 2025 02:32:41 +0000
Date: Tue, 23 Sep 2025 10:32:05 +0800
From: kernel test robot <lkp@intel.com>
To: Bo Liu <liubo03@inspur.com>, xiang@kernel.org, chao@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	Bo Liu <liubo03@inspur.com>
Subject: Re: [PATCH v4] erofs: Add support for FS_IOC_GETFSLABEL
Message-ID: <202509231033.ADjNYvqL-lkp@intel.com>
References: <20250922092937.2055-1-liubo03@inspur.com>
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
In-Reply-To: <20250922092937.2055-1-liubo03@inspur.com>
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Hi Bo,

kernel test robot noticed the following build errors:

[auto build test ERROR on xiang-erofs/dev-test]
[also build test ERROR on xiang-erofs/dev xiang-erofs/fixes linus/master v6.17-rc7 next-20250922]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Bo-Liu/erofs-Add-support-for-FS_IOC_GETFSLABEL/20250922-173127
base:   https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git dev-test
patch link:    https://lore.kernel.org/r/20250922092937.2055-1-liubo03%40inspur.com
patch subject: [PATCH v4] erofs: Add support for FS_IOC_GETFSLABEL
config: sparc64-randconfig-001-20250923 (https://download.01.org/0day-ci/archive/20250923/202509231033.ADjNYvqL-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project cafc064fc7a96b3979a023ddae1da2b499d6c954)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250923/202509231033.ADjNYvqL-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509231033.ADjNYvqL-lkp@intel.com/

All errors (new ones prefixed by >>):

>> fs/erofs/inode.c:372:47: error: call to undeclared function 'compat_ptr'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     372 |         return erofs_ioctl(filp, cmd, (unsigned long)compat_ptr(arg));
         |                                                      ^
   1 error generated.


vim +/compat_ptr +372 fs/erofs/inode.c

   367	
   368	#ifdef CONFIG_COMPAT
   369	long erofs_compat_ioctl(struct file *filp, unsigned int cmd,
   370				unsigned long arg)
   371	{
 > 372		return erofs_ioctl(filp, cmd, (unsigned long)compat_ptr(arg));
   373	}
   374	#endif
   375	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

