Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD0C44802B0
	for <lists+linux-erofs@lfdr.de>; Mon, 27 Dec 2021 18:21:16 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4JN4Fk3Xmdz2ywR
	for <lists+linux-erofs@lfdr.de>; Tue, 28 Dec 2021 04:21:14 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=YhPqARdv;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=intel.com (client-ip=192.55.52.136; helo=mga12.intel.com;
 envelope-from=lkp@intel.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=YhPqARdv; dkim-atps=neutral
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4JN4Fb2qyKz2ybH
 for <linux-erofs@lists.ozlabs.org>; Tue, 28 Dec 2021 04:21:06 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1640625667; x=1672161667;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=HGrUp3wJgJu8GbXl17s3CzPoGZmLvMjysUYz4XudtJ8=;
 b=YhPqARdviozGN7IOyqzpteRqDyZbEqPZQ+HGqAjBmQ4W6i+TRnCLxOBs
 h+E8t42rEqZdVSShB8F8QN1wr8G+50s2INpY706c58diCsS5iMpj4PSqK
 eBQb5MV7EztJ6uQFLxAoe3ljlr+p7AgP40Q2HlubbHQ7GyOnsN+8QCrYX
 /LXKHAwwTTpe5pobQwcc/vk50I+beu8UUp3U+gvep3X96Alow1pdqTKWe
 2KGq6t0XMbjxNWtD3+EEKlg2NZzRxMdUHN0XzIhP2W0S3k3TUGBQ+cnir
 V0jAOpAsFQblsMo5bfYOBLFL+viBXgfPhCXoZ1Hr86kP69oMW2yIRzNu2 w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10210"; a="221241907"
X-IronPort-AV: E=Sophos;i="5.88,240,1635231600"; d="scan'208";a="221241907"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Dec 2021 09:18:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,240,1635231600"; d="scan'208";a="686343731"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
 by orsmga005.jf.intel.com with ESMTP; 27 Dec 2021 09:18:31 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1n1tdm-0006dR-Np; Mon, 27 Dec 2021 17:18:30 +0000
Date: Tue, 28 Dec 2021 01:17:42 +0800
From: kernel test robot <lkp@intel.com>
To: Jeffle Xu <jefflexu@linux.alibaba.com>, dhowells@redhat.com,
 linux-cachefs@redhat.com, xiang@kernel.org, chao@kernel.org,
 linux-erofs@lists.ozlabs.org
Subject: Re: [PATCH v1 12/23] erofs: implement fscache-based metadata read
Message-ID: <202112280132.0kJ8Vjql-lkp@intel.com>
References: <20211227125444.21187-13-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211227125444.21187-13-jefflexu@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
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
Cc: kbuild-all@lists.01.org, tao.peng@linux.alibaba.com,
 joseph.qi@linux.alibaba.com, bo.liu@linux.alibaba.com,
 linux-fsdevel@vger.kernel.org, gerry@linux.alibaba.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Jeffle,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on dhowells-fs/fscache-next]
[cannot apply to xiang-erofs/dev-test ceph-client/for-linus linus/master v5.16-rc7 next-20211224]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Jeffle-Xu/fscache-erofs-fscache-based-demand-read-semantics/20211227-205742
base:   https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git fscache-next
config: x86_64-randconfig-a014-20211227 (https://download.01.org/0day-ci/archive/20211228/202112280132.0kJ8Vjql-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://github.com/0day-ci/linux/commit/c3453b91df3b4e89c3336453437f761d6cb6bca3
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Jeffle-Xu/fscache-erofs-fscache-based-demand-read-semantics/20211227-205742
        git checkout c3453b91df3b4e89c3336453437f761d6cb6bca3
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   vmlinux.o: warning: objtool: do_machine_check()+0x89f: call to queue_task_work() leaves .noinstr.text section
   vmlinux.o: warning: objtool: enter_from_user_mode()+0x4e: call to on_thread_stack() leaves .noinstr.text section
   vmlinux.o: warning: objtool: syscall_enter_from_user_mode()+0x59: call to on_thread_stack() leaves .noinstr.text section
   vmlinux.o: warning: objtool: syscall_enter_from_user_mode_prepare()+0x4e: call to on_thread_stack() leaves .noinstr.text section
   vmlinux.o: warning: objtool: irqentry_enter_from_user_mode()+0x4e: call to on_thread_stack() leaves .noinstr.text section
   ld: fs/erofs/fscache.o: in function `erofs_issue_op':
   fs/erofs/fscache.c:27: undefined reference to `netfs_subreq_terminated'
   ld: fs/erofs/fscache.o: in function `erofs_readpage_from_fscache':
>> fs/erofs/fscache.c:59: undefined reference to `netfs_readpage'


vim +59 fs/erofs/fscache.c

    35	
    36	struct page *erofs_readpage_from_fscache(struct erofs_cookie_ctx *ctx,
    37						 pgoff_t index)
    38	{
    39		struct folio *folio;
    40		struct page *page;
    41		struct super_block *sb = ctx->inode->i_sb;
    42		int ret;
    43	
    44		page = find_or_create_page(ctx->inode->i_mapping, index, GFP_KERNEL);
    45		if (unlikely(!page)) {
    46			erofs_err(sb, "failed to allocate page");
    47			return ERR_PTR(-ENOMEM);
    48		}
    49	
    50		/* The content is already buffered in the address space */
    51		if (PageUptodate(page)) {
    52			unlock_page(page);
    53			return page;
    54		}
    55	
    56		/* Or a new page cache is created, then read the content from fscache */
    57		folio = page_folio(page);
    58	
  > 59		ret = netfs_readpage(NULL, folio, &erofs_req_ops, ctx->cookie);
    60		if (unlikely(ret || !PageUptodate(page))) {
    61			erofs_err(sb, "failed to read from fscache");
    62			return ERR_PTR(-EINVAL);
    63		}
    64	
    65		return page;
    66	}
    67	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
