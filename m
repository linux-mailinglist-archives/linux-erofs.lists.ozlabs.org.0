Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FEE978058E
	for <lists+linux-erofs@lfdr.de>; Fri, 18 Aug 2023 07:16:50 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=WTnO6AS0;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RRqqN25jcz3cBK
	for <lists+linux-erofs@lfdr.de>; Fri, 18 Aug 2023 15:16:48 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=WTnO6AS0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=134.134.136.20; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RRqqG39Phz2ysB
	for <linux-erofs@lists.ozlabs.org>; Fri, 18 Aug 2023 15:16:38 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692335802; x=1723871802;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KSXsr4mO+68lC2eSMoW/DrLlPGBbIdc0WLzY22BGDu0=;
  b=WTnO6AS0Lus8JaSTqw/+UEsm3m9sm3GXsQ8K6qHNVHF3YdhsNHc2bDon
   ol6crbmL/817vddAxnBIoQIG4m73aojAE0n2Ybi2UDIKIulHmpEb7sUOJ
   l8phS+MLsXvqoDwl7ioYZGryM/yQ9jhd/cftohlgncT33xcRO1xAj4wR4
   xcbAZ8Q2z7TwhySI6ymKxQqx5OsFEdjD4v9HQn3P8rEoWnpF43HCBCxPT
   VnN1qreCXE7yWC6uOVJQJIGy4GstwxwFnVZZydxmPPuB2XwE2YT1G56oG
   8k9GLtJW5v535Ro8HWqKMAOj5flV+ub8Cg2C6hm/6MZd5Phr8bzPySX8R
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="363175086"
X-IronPort-AV: E=Sophos;i="6.01,182,1684825200"; 
   d="scan'208";a="363175086"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2023 22:16:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="734962618"
X-IronPort-AV: E=Sophos;i="6.01,182,1684825200"; 
   d="scan'208";a="734962618"
Received: from lkp-server02.sh.intel.com (HELO a9caf1a0cf30) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 17 Aug 2023 22:16:26 -0700
Received: from kbuild by a9caf1a0cf30 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qWrq6-000282-35;
	Fri, 18 Aug 2023 05:16:14 +0000
Date: Fri, 18 Aug 2023 13:15:47 +0800
From: kernel test robot <lkp@intel.com>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] mm: Change calling convention for ->huge_fault
Message-ID: <202308181315.Z4HfWZsh-lkp@intel.com>
References: <20230817200150.1230317-1-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230817200150.1230317-1-willy@infradead.org>
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
Cc: nvdimm@lists.linux.dev, "Matthew Wilcox \(Oracle\)" <willy@infradead.org>, linux-xfs@vger.kernel.org, Linux Memory Management List <linux-mm@kvack.org>, linux-cxl@vger.kernel.org, oe-kbuild-all@lists.linux.dev, linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Matthew,

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-everything]

url:    https://github.com/intel-lab-lkp/linux/commits/Matthew-Wilcox-Oracle/mm-Change-calling-convention-for-huge_fault/20230818-040348
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20230817200150.1230317-1-willy%40infradead.org
patch subject: [PATCH] mm: Change calling convention for ->huge_fault
config: arc-randconfig-r043-20230818 (https://download.01.org/0day-ci/archive/20230818/202308181315.Z4HfWZsh-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230818/202308181315.Z4HfWZsh-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308181315.Z4HfWZsh-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/asm-generic/io.h:1048,
                    from arch/arc/include/asm/io.h:232,
                    from include/linux/io.h:13,
                    from include/linux/irq.h:20,
                    from include/asm-generic/hardirq.h:17,
                    from ./arch/arc/include/generated/asm/hardirq.h:1,
                    from include/linux/hardirq.h:11,
                    from include/linux/interrupt.h:11,
                    from include/linux/kernel_stat.h:9,
                    from mm/memory.c:42:
   mm/memory.c: In function 'create_huge_pmd':
>> include/linux/pgtable.h:8:38: error: 'PTE_SHIFT' undeclared (first use in this function); did you mean 'PUD_SHIFT'?
       8 | #define PMD_ORDER       (PMD_SHIFT - PTE_SHIFT)
         |                                      ^~~~~~~~~
   mm/memory.c:4876:53: note: in expansion of macro 'PMD_ORDER'
    4876 |                 return vma->vm_ops->huge_fault(vmf, PMD_ORDER);
         |                                                     ^~~~~~~~~
   include/linux/pgtable.h:8:38: note: each undeclared identifier is reported only once for each function it appears in
       8 | #define PMD_ORDER       (PMD_SHIFT - PTE_SHIFT)
         |                                      ^~~~~~~~~
   mm/memory.c:4876:53: note: in expansion of macro 'PMD_ORDER'
    4876 |                 return vma->vm_ops->huge_fault(vmf, PMD_ORDER);
         |                                                     ^~~~~~~~~
   mm/memory.c: In function 'wp_huge_pmd':
>> include/linux/pgtable.h:8:38: error: 'PTE_SHIFT' undeclared (first use in this function); did you mean 'PUD_SHIFT'?
       8 | #define PMD_ORDER       (PMD_SHIFT - PTE_SHIFT)
         |                                      ^~~~~~~~~
   mm/memory.c:4896:60: note: in expansion of macro 'PMD_ORDER'
    4896 |                         ret = vma->vm_ops->huge_fault(vmf, PMD_ORDER);
         |                                                            ^~~~~~~~~


vim +8 include/linux/pgtable.h

     7	
   > 8	#define PMD_ORDER	(PMD_SHIFT - PTE_SHIFT)
     9	#define PUD_ORDER	(PUD_SHIFT - PTE_SHIFT)
    10	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
