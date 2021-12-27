Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EA9247FEC7
	for <lists+linux-erofs@lfdr.de>; Mon, 27 Dec 2021 16:33:48 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4JN1sj6wyvz2yn2
	for <lists+linux-erofs@lfdr.de>; Tue, 28 Dec 2021 02:33:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=jyE+PCcL;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=intel.com (client-ip=192.55.52.136; helo=mga12.intel.com;
 envelope-from=lkp@intel.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=jyE+PCcL; dkim-atps=neutral
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4JN1sb49Hsz2xtp
 for <linux-erofs@lists.ozlabs.org>; Tue, 28 Dec 2021 02:33:33 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1640619219; x=1672155219;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=0ftgT5rz4My36TxPcpmhbqQvJm2D6myU8LmuRkWvQ4k=;
 b=jyE+PCcLeKTa1J8eUePn5A9/B9b6c7wLcNgZUrPdnkCsScXtGggrS7gZ
 a2/FSuxBYUugdjL0g2RFWcqAiPSxvPBopgaxgQJnrPDuH5P+KKy2mRkQJ
 w56Tyw1Z+ogcHbT4qXv1hZB9HwJY25oVNoIKDSoBWoE0hHk/bBCXaVKpc
 7dNcRwwwm3ItclPi2rsHkiCc7UYQ+S69AqvGrHm/vg2QDUJwEXF2eKyJd
 KlEkQPD568euqJsNfDauIUewHJnWV4AVKRIowkL1vSuY+Pu6Dzhb7+e2A
 +PhEkbdHBCyXx/0y6FK0dDB1l+OK57LhRq5xiv6AwfOac93CWYOUlbeog A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10209"; a="221224510"
X-IronPort-AV: E=Sophos;i="5.88,239,1635231600"; d="scan'208";a="221224510"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Dec 2021 07:32:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,239,1635231600"; d="scan'208";a="618475900"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
 by orsmga004.jf.intel.com with ESMTP; 27 Dec 2021 07:32:27 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1n1rz8-0006UP-SR; Mon, 27 Dec 2021 15:32:26 +0000
Date: Mon, 27 Dec 2021 23:32:21 +0800
From: kernel test robot <lkp@intel.com>
To: Jeffle Xu <jefflexu@linux.alibaba.com>, dhowells@redhat.com,
 linux-cachefs@redhat.com, xiang@kernel.org, chao@kernel.org,
 linux-erofs@lists.ozlabs.org
Subject: Re: [PATCH v1 19/23] cachefiles: implement .demand_read() for demand
 read
Message-ID: <202112272340.1ho7sEjG-lkp@intel.com>
References: <20211227125444.21187-20-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211227125444.21187-20-jefflexu@linux.alibaba.com>
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

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on dhowells-fs/fscache-next]
[cannot apply to xiang-erofs/dev-test ceph-client/for-linus linus/master v5.16-rc7 next-20211224]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Jeffle-Xu/fscache-erofs-fscache-based-demand-read-semantics/20211227-205742
base:   https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git fscache-next
config: csky-defconfig (https://download.01.org/0day-ci/archive/20211227/202112272340.1ho7sEjG-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/54c300b4598e3f2836d8233681da387fe388cfda
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Jeffle-Xu/fscache-erofs-fscache-based-demand-read-semantics/20211227-205742
        git checkout 54c300b4598e3f2836d8233681da387fe388cfda
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=csky SHELL=/bin/bash fs/cachefiles/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   fs/cachefiles/io.c:564:5: warning: no previous prototype for 'cachefiles_demand_read' [-Wmissing-prototypes]
     564 | int cachefiles_demand_read(struct netfs_cache_resources *cres,
         |     ^~~~~~~~~~~~~~~~~~~~~~
   In function 'cachefiles_alloc_req',
       inlined from 'cachefiles_demand_read' at fs/cachefiles/io.c:575:8:
>> fs/cachefiles/io.c:557:9: warning: 'strncpy' specified bound 255 equals destination size [-Wstringop-truncation]
     557 |         strncpy(req_in->path, object->d_name, sizeof(req_in->path));
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/strncpy +557 fs/cachefiles/io.c

   541	
   542	static struct cachefiles_req *cachefiles_alloc_req(struct cachefiles_object *object,
   543							   loff_t start_pos,
   544							   size_t len)
   545	{
   546		struct cachefiles_req *req;
   547		struct cachefiles_req_in *req_in;
   548	
   549		req = kzalloc(sizeof(*req), GFP_KERNEL);
   550		if (!req)
   551			return NULL;
   552	
   553		req_in = &req->req_in;
   554	
   555		req_in->off = start_pos;
   556		req_in->len = len;
 > 557		strncpy(req_in->path, object->d_name, sizeof(req_in->path));
   558	
   559		init_completion(&req->done);
   560	
   561		return req;
   562	}
   563	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
