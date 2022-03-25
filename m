Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id A16A14E7B23
	for <lists+linux-erofs@lfdr.de>; Sat, 26 Mar 2022 00:27:34 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KQJCk2Lqnz30CP
	for <lists+linux-erofs@lfdr.de>; Sat, 26 Mar 2022 10:27:30 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=YGU+yalV;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=intel.com (client-ip=192.55.52.136; helo=mga12.intel.com;
 envelope-from=lkp@intel.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=YGU+yalV; dkim-atps=neutral
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KQJCc68zCz2yPj
 for <linux-erofs@lists.ozlabs.org>; Sat, 26 Mar 2022 10:27:18 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1648250845; x=1679786845;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=XkoxMwHd9gW4bb7hINhoqrJqu4OqA0ycYEJM8nkG41Y=;
 b=YGU+yalVzJWIhm9cUV9WwNsgBhTDwBxPUnaXnv5tDvaQNdveLyD9sJmU
 2hKUaPM3Qv3hVeH/lO3C/Qo5ovbFA7vzvX3kaJVGSyJcQSTXPeUTPfbAV
 KmmzKOgiapquGff9L6RVMBiel7J/xLx2/jlvO14P36xqZMfxYm5ZzbjTX
 /Lq2bjikh8InXZeKNKUMu3J26FE4KfO813pKovNpEpD/G7v7xIryzH9OC
 2Ee2SQrEtDdTP/UXeOlrJQ7td8AS9igblfusp7y5421R5L22DGG9a2A4s
 Wu5qZMTVMPjiXN2HEeUnMaP/fF7wCCKpCugGkuYvkp5XK50dVMwLDJMOO w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10297"; a="238672408"
X-IronPort-AV: E=Sophos;i="5.90,211,1643702400"; d="scan'208";a="238672408"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Mar 2022 16:26:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,211,1643702400"; d="scan'208";a="553371036"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
 by fmsmga007.fm.intel.com with ESMTP; 25 Mar 2022 16:26:11 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1nXtJq-000Mii-Nz; Fri, 25 Mar 2022 23:26:10 +0000
Date: Sat, 26 Mar 2022 07:25:58 +0800
From: kernel test robot <lkp@intel.com>
To: Jeffle Xu <jefflexu@linux.alibaba.com>, dhowells@redhat.com,
 linux-cachefs@redhat.com, xiang@kernel.org, chao@kernel.org,
 linux-erofs@lists.ozlabs.org
Subject: Re: [PATCH v6 03/22] cachefiles: notify user daemon with anon_fd
 when looking up cookie
Message-ID: <202203260720.uA5o7k5w-lkp@intel.com>
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
Cc: kbuild-all@lists.01.org, gregkh@linuxfoundation.org, llvm@lists.linux.dev,
 fannaihao@baidu.com, willy@infradead.org, linux-kernel@vger.kernel.org,
 tianzichen@kuaishou.com, joseph.qi@linux.alibaba.com,
 linux-fsdevel@vger.kernel.org, luodaowen.backend@bytedance.com,
 gerry@linux.alibaba.com, torvalds@linux-foundation.org
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
config: i386-randconfig-a002 (https://download.01.org/0day-ci/archive/20220326/202203260720.uA5o7k5w-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 0f6d9501cf49ce02937099350d08f20c4af86f3d)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/ec8aa2f84eb47244377e4b822dd77d82ee54714a
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Jeffle-Xu/fscache-erofs-fscache-based-on-demand-read-semantics/20220325-203555
        git checkout ec8aa2f84eb47244377e4b822dd77d82ee54714a
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash fs/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

   In file included from fs/cachefiles/cache.c:11:
>> fs/cachefiles/internal.h:285:9: warning: no previous prototype for function 'cachefiles_ondemand_daemon_read' [-Wmissing-prototypes]
   ssize_t cachefiles_ondemand_daemon_read(struct cachefiles_cache *cache,
           ^
   fs/cachefiles/internal.h:285:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   ssize_t cachefiles_ondemand_daemon_read(struct cachefiles_cache *cache,
   ^
   static 
   1 warning generated.
--
>> ld.lld: error: duplicate symbol: cachefiles_ondemand_daemon_read
   >>> defined at internal.h:287 (fs/cachefiles/internal.h:287)
   >>> fs/cachefiles/cache.o:(cachefiles_ondemand_daemon_read)
   >>> defined at internal.h:287 (fs/cachefiles/internal.h:287)
   >>> fs/cachefiles/daemon.o:(.text+0x0)
--
>> ld.lld: error: duplicate symbol: cachefiles_ondemand_daemon_read
   >>> defined at internal.h:287 (fs/cachefiles/internal.h:287)
   >>> fs/cachefiles/cache.o:(cachefiles_ondemand_daemon_read)
   >>> defined at internal.h:287 (fs/cachefiles/internal.h:287)
   >>> fs/cachefiles/interface.o:(.text+0x0)
--
>> ld.lld: error: duplicate symbol: cachefiles_ondemand_daemon_read
   >>> defined at internal.h:287 (fs/cachefiles/internal.h:287)
   >>> fs/cachefiles/cache.o:(cachefiles_ondemand_daemon_read)
   >>> defined at internal.h:287 (fs/cachefiles/internal.h:287)
   >>> fs/cachefiles/io.o:(.text+0x0)
--
>> ld.lld: error: duplicate symbol: cachefiles_ondemand_daemon_read
   >>> defined at internal.h:287 (fs/cachefiles/internal.h:287)
   >>> fs/cachefiles/cache.o:(cachefiles_ondemand_daemon_read)
   >>> defined at internal.h:287 (fs/cachefiles/internal.h:287)
   >>> fs/cachefiles/key.o:(.text+0x0)
--
>> ld.lld: error: duplicate symbol: cachefiles_ondemand_daemon_read
   >>> defined at internal.h:287 (fs/cachefiles/internal.h:287)
   >>> fs/cachefiles/cache.o:(cachefiles_ondemand_daemon_read)
   >>> defined at internal.h:287 (fs/cachefiles/internal.h:287)
   >>> fs/cachefiles/main.o:(.text+0x38C0)
--
>> ld.lld: error: duplicate symbol: cachefiles_ondemand_daemon_read
   >>> defined at internal.h:287 (fs/cachefiles/internal.h:287)
   >>> fs/cachefiles/cache.o:(cachefiles_ondemand_daemon_read)
   >>> defined at internal.h:287 (fs/cachefiles/internal.h:287)
   >>> fs/cachefiles/namei.o:(.text+0x0)
--
>> ld.lld: error: duplicate symbol: cachefiles_ondemand_daemon_read
   >>> defined at internal.h:287 (fs/cachefiles/internal.h:287)
   >>> fs/cachefiles/cache.o:(cachefiles_ondemand_daemon_read)
   >>> defined at internal.h:287 (fs/cachefiles/internal.h:287)
   >>> fs/cachefiles/security.o:(.text+0x0)
--
>> ld.lld: error: duplicate symbol: cachefiles_ondemand_daemon_read
   >>> defined at internal.h:287 (fs/cachefiles/internal.h:287)
   >>> fs/cachefiles/cache.o:(cachefiles_ondemand_daemon_read)
   >>> defined at internal.h:287 (fs/cachefiles/internal.h:287)
   >>> fs/cachefiles/volume.o:(.text+0x0)
--
>> ld.lld: error: duplicate symbol: cachefiles_ondemand_daemon_read
   >>> defined at internal.h:287 (fs/cachefiles/internal.h:287)
   >>> fs/cachefiles/cache.o:(cachefiles_ondemand_daemon_read)
   >>> defined at internal.h:287 (fs/cachefiles/internal.h:287)
   >>> fs/cachefiles/xattr.o:(.text+0x0)

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
