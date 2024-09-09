Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 33F1397112E
	for <lists+linux-erofs@lfdr.de>; Mon,  9 Sep 2024 10:08:00 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4X2KFp1XH6z2yPM
	for <lists+linux-erofs@lfdr.de>; Mon,  9 Sep 2024 18:07:58 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.19
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1725869276;
	cv=none; b=LvnxH1DXdHM1sVMEOJ08JAFlg/bm208Uq1H3eP7JMMCX8s/BFuPCbHdHzQwq3F7dPnS014aFjsk44Fnaz2BHkibWq2LWCTEjIFx/lTmnJxYABMsQQk2RrxmdQ7lLPvJl2xzL2HfXv8uPyppQb/AwZrQPOzGpSotIs16iCqzkb8/H59Gv7g8Ch0uImjWdCkscZVW+g0WtygxGis7Oyo6m2c6Ll4BwE9IPmcaDGagJ0R5ZsOHVYc1LE4Tt3MvQMttAYx9Z/jCcJ6oCLQEWQGIZTH7Ak2vGxCqG7R7esWbqTyrcIEkd549sOPKT0kaD8UG1xYzuWJPRmi1ADX8bT92TXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1725869276; c=relaxed/relaxed;
	bh=HDrUUA7pq9sQ/zOhom/V4HJFxsAGC2YXuTRTw5MPDY8=;
	h=DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:MIME-Version:
	 Content-Type:Content-Disposition; b=nWi4N8CX3q97Uay6pLMDQqoG5seo2ALNq85h0nS833CAcv4bUKB7y5t9mQYuy5dHfNJgVDOjwGYcZI/HZAIuT3xcWOP9Fso020qcjCqo62pwile/x0ibf9wS3F0jpBI+iwX1GBPkzb70KwziZ5WawQFpqZOwQdVE+uL7FNfJIObWqSXjYxnAxq2ATZ32khlZZTHv4/vY5m0FbH9/qk5C+2ZTlkFehW+QiezTRiPsO1hsJ91ByWQUtHois2GRfg0rqUYMA7hjPQC5F/yJnhztfG6bMNyMeY4DH0Lai7nN1RIZVJHQM9wEJJMq/DrjW93/XxqeI6+9aq6M7UM8uA+tKw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=CpGTErUy; dkim-atps=neutral; spf=pass (client-ip=192.198.163.19; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=CpGTErUy;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.198.163.19; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4X2KFk6QbBz2xFm
	for <linux-erofs@lists.ozlabs.org>; Mon,  9 Sep 2024 18:07:52 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725869275; x=1757405275;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=j9AgnFvesijEh3/HEGR15aDkd+PH8EuQUkkwSCvuTNM=;
  b=CpGTErUyFP7ITpp4sjT48CA+y1CJIcNVYPm5xW4nVzRs7jBQr8u9K1Vl
   THrtXgb0+NCssrCjwE8r1dHcbdgy9HAhwffE8tS+XwQO+SN4+gtfWYCk4
   7sWAsGV1Z2rPiTnnQTIU0QSQTFw8mVhslSv4QwDi4B5tdbJeAk0lGuCkr
   01ULyszah29qebYEe1F6ReymqjrxyaEOvNay166bu8zs74rn7vsAPb9HL
   DkmUzLGFLAIMubw+krrb5pTKDCRseIklJtT3Okc1m5nWyO9CaCXokcgMv
   lDWNBLVtP/FnfXyDijK8n2ghrwzhXORh58+dK8BFNJ7IT73BNF5Emkos8
   g==;
X-CSE-ConnectionGUID: qlLibMGISISeGj/FZyOtGQ==
X-CSE-MsgGUID: YcTCnEVcTlqH1v75a1MyHA==
X-IronPort-AV: E=McAfee;i="6700,10204,11189"; a="24096903"
X-IronPort-AV: E=Sophos;i="6.10,213,1719903600"; 
   d="scan'208";a="24096903"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2024 01:07:49 -0700
X-CSE-ConnectionGUID: oDF8DDqQTvS10DNKBmaDZg==
X-CSE-MsgGUID: E7BKaxo4TNOJamtIvZ+Ptg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,213,1719903600"; 
   d="scan'208";a="66576164"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 09 Sep 2024 01:07:47 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1snZR2-000EUw-1S;
	Mon, 09 Sep 2024 08:07:44 +0000
Date: Mon, 9 Sep 2024 16:07:41 +0800
From: kernel test robot <lkp@intel.com>
To: Yiyang Wu <toolmanp@tlmp.cc>
Subject: [xiang-erofs:dev-test 9/12] fs/erofs/inode.c:19:56: error: 'off'
 undeclared
Message-ID: <202409091602.2XlSy6FO-lkp@intel.com>
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
Cc: Chao Yu <yuchao0@huawei.com>, linux-erofs@lists.ozlabs.org, oe-kbuild-all@lists.linux.dev
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git dev-test
head:   c45b42bcbc9c3fb421b8a4f7b3112b401971530b
commit: afcb9dd4a55ab82970251b75c2a5461025ed4d8a [9/12] erofs: refactor read_inode calling convention
config: i386-buildonly-randconfig-003-20240909 (https://download.01.org/0day-ci/archive/20240909/202409091602.2XlSy6FO-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240909/202409091602.2XlSy6FO-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409091602.2XlSy6FO-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/string.h:12,
                    from arch/x86/include/asm/page_32.h:18,
                    from arch/x86/include/asm/page.h:14,
                    from arch/x86/include/asm/thread_info.h:12,
                    from include/linux/thread_info.h:60,
                    from include/linux/spinlock.h:60,
                    from include/linux/wait.h:9,
                    from include/linux/wait_bit.h:8,
                    from include/linux/fs.h:6,
                    from fs/erofs/internal.h:10,
                    from fs/erofs/xattr.h:9,
                    from fs/erofs/inode.c:7:
   fs/erofs/inode.c: In function 'erofs_fill_symlink':
>> fs/erofs/inode.c:19:56: error: 'off' undeclared (first use in this function)
      19 |             check_add_overflow(m_pofs, inode->i_size, &off) ||
         |                                                        ^~~
   include/linux/overflow.h:68:60: note: in definition of macro 'check_add_overflow'
      68 |         __must_check_overflow(__builtin_add_overflow(a, b, d))
         |                                                            ^
   fs/erofs/inode.c:19:56: note: each undeclared identifier is reported only once for each function it appears in
      19 |             check_add_overflow(m_pofs, inode->i_size, &off) ||
         |                                                        ^~~
   include/linux/overflow.h:68:60: note: in definition of macro 'check_add_overflow'
      68 |         __must_check_overflow(__builtin_add_overflow(a, b, d))
         |                                                            ^


vim +/off +19 fs/erofs/inode.c

    10	
    11	static int erofs_fill_symlink(struct inode *inode, void *kaddr,
    12				      unsigned int m_pofs)
    13	{
    14		struct erofs_inode *vi = EROFS_I(inode);
    15	
    16		m_pofs += vi->xattr_isize;
    17		/* check if it cannot be handled with fast symlink scheme */
    18		if (vi->datalayout != EROFS_INODE_FLAT_INLINE || inode->i_size < 0 ||
  > 19		    check_add_overflow(m_pofs, inode->i_size, &off) ||
    20		    off > i_blocksize(inode))
    21			return 0;
    22	
    23		inode->i_link = kmemdup_nul(kaddr + m_pofs, inode->i_size, GFP_KERNEL);
    24		return inode->i_link ? 0 : -ENOMEM;
    25	}
    26	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
