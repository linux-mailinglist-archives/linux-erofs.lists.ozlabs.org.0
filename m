Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 02F6E4E7ABB
	for <lists+linux-erofs@lfdr.de>; Fri, 25 Mar 2022 21:53:57 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KQDpV6RCFz30CP
	for <lists+linux-erofs@lfdr.de>; Sat, 26 Mar 2022 07:53:54 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=lQnKP1qB;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=intel.com (client-ip=192.55.52.151; helo=mga17.intel.com;
 envelope-from=lkp@intel.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=lQnKP1qB; dkim-atps=neutral
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KQDpN6NN2z2yY1
 for <linux-erofs@lists.ozlabs.org>; Sat, 26 Mar 2022 07:53:43 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1648241629; x=1679777629;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=P3gwNXe0u8BsPFKCZRFA9VltWIcjiuRgNKGEuiruPN4=;
 b=lQnKP1qBCRSBh4YLi19nMfVHGFF2wb77fffUAZLyha3in6HBBMcxDnQv
 ZWI3NpuAS7hxLvnZ4F1u7Uvdr1pdkkXrkEwUVmff22JEk3vGW4zNKl9QE
 elkJpfPo1BAZzICJnmnX4WtXdD7lvGivy6csJfnisJb2U7YMwWRFQJG2G
 mpKFjswIjgAb0LLvM2gH7fY4XzHhiU5EOKHIhx25/9Tt+J/0cRWD1DUIb
 esCze9/cXOKc9g93KjZ0/EpZ5fueWQz1y3Og/EzaG4+SgPrBfYtD6877/
 6IdbNpEtTAbOr24fIKPddY20IH5J96pMVtT1XaPpvpB94SxIIfyzT8rwE g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10297"; a="239316375"
X-IronPort-AV: E=Sophos;i="5.90,211,1643702400"; d="scan'208";a="239316375"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Mar 2022 13:52:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,211,1643702400"; d="scan'208";a="826145419"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
 by fmsmga005.fm.intel.com with ESMTP; 25 Mar 2022 13:52:24 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1nXqv2-000Mad-9K; Fri, 25 Mar 2022 20:52:24 +0000
Date: Sat, 26 Mar 2022 04:52:21 +0800
From: kernel test robot <lkp@intel.com>
To: Jeffle Xu <jefflexu@linux.alibaba.com>, dhowells@redhat.com,
 linux-cachefs@redhat.com, xiang@kernel.org, chao@kernel.org,
 linux-erofs@lists.ozlabs.org
Subject: Re: [PATCH v6 03/22] cachefiles: notify user daemon with anon_fd
 when looking up cookie
Message-ID: <202203260406.Ay5o7T9U-lkp@intel.com>
References: <20220325122223.102958-4-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220325122223.102958-4-jefflexu@linux.alibaba.com>
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
Cc: kbuild-all@lists.01.org, gregkh@linuxfoundation.org, fannaihao@baidu.com,
 willy@infradead.org, linux-kernel@vger.kernel.org, tianzichen@kuaishou.com,
 joseph.qi@linux.alibaba.com, linux-fsdevel@vger.kernel.org,
 luodaowen.backend@bytedance.com, gerry@linux.alibaba.com,
 torvalds@linux-foundation.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Jeffle,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on trondmy-nfs/linux-next]
[also build test ERROR on rostedt-trace/for-next linus/master v5.17]
[cannot apply to xiang-erofs/dev-test dhowells-fs/fscache-next next-20220325]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Jeffle-Xu/fscache-erofs-fscache-based-on-demand-read-semantics/20220325-203555
base:   git://git.linux-nfs.org/projects/trondmy/linux-nfs.git linux-next
config: csky-defconfig (https://download.01.org/0day-ci/archive/20220326/202203260406.Ay5o7T9U-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/ec8aa2f84eb47244377e4b822dd77d82ee54714a
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Jeffle-Xu/fscache-erofs-fscache-based-on-demand-read-semantics/20220325-203555
        git checkout ec8aa2f84eb47244377e4b822dd77d82ee54714a
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=csky SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   csky-linux-ld: fs/cachefiles/daemon.o: in function `cachefiles_ondemand_daemon_read':
>> daemon.c:(.text+0x97c): multiple definition of `cachefiles_ondemand_daemon_read'; fs/cachefiles/cache.o:cache.c:(.text+0x18): first defined here
   csky-linux-ld: fs/cachefiles/interface.o: in function `cachefiles_ondemand_daemon_read':
   interface.c:(.text+0x1ec): multiple definition of `cachefiles_ondemand_daemon_read'; fs/cachefiles/cache.o:cache.c:(.text+0x18): first defined here
   csky-linux-ld: fs/cachefiles/io.o: in function `cachefiles_ondemand_daemon_read':
   io.c:(.text+0x720): multiple definition of `cachefiles_ondemand_daemon_read'; fs/cachefiles/cache.o:cache.c:(.text+0x18): first defined here
   csky-linux-ld: fs/cachefiles/key.o: in function `cachefiles_ondemand_daemon_read':
   key.c:(.text+0x0): multiple definition of `cachefiles_ondemand_daemon_read'; fs/cachefiles/cache.o:cache.c:(.text+0x18): first defined here
   csky-linux-ld: fs/cachefiles/main.o: in function `cachefiles_ondemand_daemon_read':
   main.c:(.text+0x0): multiple definition of `cachefiles_ondemand_daemon_read'; fs/cachefiles/cache.o:cache.c:(.text+0x18): first defined here
   csky-linux-ld: fs/cachefiles/namei.o: in function `cachefiles_ondemand_daemon_read':
   namei.c:(.text+0xf8): multiple definition of `cachefiles_ondemand_daemon_read'; fs/cachefiles/cache.o:cache.c:(.text+0x18): first defined here
   csky-linux-ld: fs/cachefiles/security.o: in function `cachefiles_ondemand_daemon_read':
   security.c:(.text+0x24): multiple definition of `cachefiles_ondemand_daemon_read'; fs/cachefiles/cache.o:cache.c:(.text+0x18): first defined here
   csky-linux-ld: fs/cachefiles/volume.o: in function `cachefiles_ondemand_daemon_read':
   volume.c:(.text+0x0): multiple definition of `cachefiles_ondemand_daemon_read'; fs/cachefiles/cache.o:cache.c:(.text+0x18): first defined here
   csky-linux-ld: fs/cachefiles/xattr.o: in function `cachefiles_ondemand_daemon_read':
   xattr.c:(.text+0x0): multiple definition of `cachefiles_ondemand_daemon_read'; fs/cachefiles/cache.o:cache.c:(.text+0x18): first defined here

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
