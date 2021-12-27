Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7929448014B
	for <lists+linux-erofs@lfdr.de>; Mon, 27 Dec 2021 16:58:11 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4JN2Ps2TDvz2yw9
	for <lists+linux-erofs@lfdr.de>; Tue, 28 Dec 2021 02:58:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=NQC0JyJ6;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=intel.com (client-ip=134.134.136.24; helo=mga09.intel.com;
 envelope-from=lkp@intel.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=NQC0JyJ6; dkim-atps=neutral
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4JN2PD0W6nz305F
 for <linux-erofs@lists.ozlabs.org>; Tue, 28 Dec 2021 02:57:35 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1640620656; x=1672156656;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=PxtyPzt0KLfSLLa1pPBudg9doH4Gy9uQA/cjdZanweI=;
 b=NQC0JyJ6GbLG3HjuHkkgzbzf7aBDd07P1BkOeswc4B+cxEKR3dUhP7BI
 PPneevQ3S1SV3tKBLCFMV9pSO2LQHcMbcfqkmXmoaiBj72p4S4VP3NDLR
 o0UNFZpQWD+CNz94VzJHsKsq+oHll8lXTNT6INiMALX6/iYRVqBoYj1pV
 a0eGaZhybaNn0O9J6rM9qKxNh4IOS+b3NvGkQsaNluWkojVCfjSGtUiec
 qinEgF71rOS9yk+p74ubJPOcYZEQJvfLJpcmBbCIJMs8QgMW3qeBOXfvy
 4eCW1HqjOKEmxkGAKvECDyYQIm63fGqDPkKozta2u5AMuAIPWJKjAYQ6w Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10209"; a="241031711"
X-IronPort-AV: E=Sophos;i="5.88,239,1635231600"; d="scan'208";a="241031711"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Dec 2021 07:56:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,239,1635231600"; d="scan'208";a="686318910"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
 by orsmga005.jf.intel.com with ESMTP; 27 Dec 2021 07:56:28 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1n1sMO-0006XQ-Bx; Mon, 27 Dec 2021 15:56:28 +0000
Date: Mon, 27 Dec 2021 23:55:48 +0800
From: kernel test robot <lkp@intel.com>
To: Jeffle Xu <jefflexu@linux.alibaba.com>, dhowells@redhat.com,
 linux-cachefs@redhat.com, xiang@kernel.org, chao@kernel.org,
 linux-erofs@lists.ozlabs.org
Subject: Re: [PATCH v1 19/23] cachefiles: implement .demand_read() for demand
 read
Message-ID: <202112272353.ekKESQX6-lkp@intel.com>
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
Cc: kbuild-all@lists.01.org, llvm@lists.linux.dev, tao.peng@linux.alibaba.com,
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
config: i386-randconfig-r005-20211227 (https://download.01.org/0day-ci/archive/20211227/202112272353.ekKESQX6-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 511726c64d3b6cca66f7c54d457d586aa3129f67)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/54c300b4598e3f2836d8233681da387fe388cfda
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Jeffle-Xu/fscache-erofs-fscache-based-demand-read-semantics/20211227-205742
        git checkout 54c300b4598e3f2836d8233681da387fe388cfda
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash fs/cachefiles/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> fs/cachefiles/io.c:564:5: warning: no previous prototype for function 'cachefiles_demand_read' [-Wmissing-prototypes]
   int cachefiles_demand_read(struct netfs_cache_resources *cres,
       ^
   fs/cachefiles/io.c:564:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int cachefiles_demand_read(struct netfs_cache_resources *cres,
   ^
   static 
   1 warning generated.


vim +/cachefiles_demand_read +564 fs/cachefiles/io.c

   563	
 > 564	int cachefiles_demand_read(struct netfs_cache_resources *cres,
   565				   loff_t start_pos, size_t len)
   566	{
   567		struct cachefiles_object *object;
   568		struct cachefiles_cache *cache;
   569		struct cachefiles_req *req;
   570		int ret;
   571	
   572		object = cachefiles_cres_object(cres);
   573		cache = object->volume->cache;
   574	
   575		req = cachefiles_alloc_req(object, start_pos, len);
   576		if (!req)
   577			return -ENOMEM;
   578	
   579		spin_lock(&cache->reqs_lock);
   580		ret = idr_alloc(&cache->reqs, req, 0, 0, GFP_KERNEL);
   581		if (ret >= 0)
   582			req->req_in.id = ret;
   583		spin_unlock(&cache->reqs_lock);
   584		if (ret < 0) {
   585			kfree(req);
   586			return -ENOMEM;
   587		}
   588	
   589		wake_up_all(&cache->daemon_pollwq);
   590	
   591		wait_for_completion(&req->done);
   592		kfree(req);
   593	
   594		return 0;
   595	}
   596	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
