Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7E304DBA66
	for <lists+linux-erofs@lfdr.de>; Wed, 16 Mar 2022 22:53:56 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KJkYt4NSnz305B
	for <lists+linux-erofs@lfdr.de>; Thu, 17 Mar 2022 08:53:54 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=GU7Q1oQj;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=intel.com (client-ip=134.134.136.31; helo=mga06.intel.com;
 envelope-from=lkp@intel.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=GU7Q1oQj; dkim-atps=neutral
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KJkYl3Bb7z2ynV
 for <linux-erofs@lists.ozlabs.org>; Thu, 17 Mar 2022 08:53:41 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1647467627; x=1679003627;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=oaJPU3mzsyrhJU2vCb6iuLnJLW5/DsmXT3TMUmBnOB8=;
 b=GU7Q1oQjN2g/PdDPvAFXt7FbEuoGDz0NpuOv6hHa4BBDyOSbX+h/DHCd
 mb6kvt4cq//ktDQgmXTQ24PsOBCRxvt7YJqO8YvvQnv5X08pIk9iS21zc
 LbwQ5jJ2bgklPMNBm6FqemrNTLNRkFI8UPGTS+Jd0qvHSXLJj19mmlvG3
 yAeJZgMddnkvJ5EFuQKS9yg27w2xcuZntnmKFVaFyX/P/YukYmFTzr0N6
 RIX+94Zh+ofXLMs7gE6j2LzeqVwem8gKrL6Yf3WZDyH0oWDM5celdmCHx
 6Gf7i/ohYaUgLWm8kjNeg3HKsAxTIA1zK11SLYASiq5NrmkXNc/MMyRPy w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10288"; a="317440147"
X-IronPort-AV: E=Sophos;i="5.90,187,1643702400"; d="scan'208";a="317440147"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Mar 2022 14:52:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,187,1643702400"; d="scan'208";a="646820651"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
 by orsmga004.jf.intel.com with ESMTP; 16 Mar 2022 14:52:33 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1nUbZI-000Cyl-AM; Wed, 16 Mar 2022 21:52:32 +0000
Date: Thu, 17 Mar 2022 05:52:08 +0800
From: kernel test robot <lkp@intel.com>
To: Jeffle Xu <jefflexu@linux.alibaba.com>, dhowells@redhat.com,
 linux-cachefs@redhat.com, xiang@kernel.org, chao@kernel.org,
 linux-erofs@lists.ozlabs.org
Subject: Re: [PATCH v5 11/22] erofs: register global fscache volume
Message-ID: <202203170512.Se1LRa68-lkp@intel.com>
References: <20220316131723.111553-12-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220316131723.111553-12-jefflexu@linux.alibaba.com>
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
 willy@infradead.org, linux-kernel@vger.kernel.org, joseph.qi@linux.alibaba.com,
 linux-fsdevel@vger.kernel.org, luodaowen.backend@bytedance.com,
 gerry@linux.alibaba.com, torvalds@linux-foundation.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Jeffle,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on trondmy-nfs/linux-next]
[also build test ERROR on rostedt-trace/for-next linus/master v5.17-rc8]
[cannot apply to xiang-erofs/dev-test dhowells-fs/fscache-next next-20220316]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Jeffle-Xu/fscache-erofs-fscache-based-on-demand-read-semantics/20220316-214711
base:   git://git.linux-nfs.org/projects/trondmy/linux-nfs.git linux-next
config: hexagon-randconfig-r041-20220313 (https://download.01.org/0day-ci/archive/20220317/202203170512.Se1LRa68-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project a6ec1e3d798f8eab43fb3a91028c6ab04e115fcb)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/f52882624bb750e533d0ffa591c3903f08f6d8bb
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Jeffle-Xu/fscache-erofs-fscache-based-on-demand-read-semantics/20220316-214711
        git checkout f52882624bb750e533d0ffa591c3903f08f6d8bb
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: __fscache_relinquish_volume
   >>> referenced by fscache.c
   >>> erofs/fscache.o:(erofs_exit_fscache) in archive fs/built-in.a
   >>> referenced by fscache.c
   >>> erofs/fscache.o:(erofs_exit_fscache) in archive fs/built-in.a
--
>> ld.lld: error: undefined symbol: __fscache_acquire_volume
   >>> referenced by fscache.c
   >>> erofs/fscache.o:(erofs_init_fscache) in archive fs/built-in.a
   >>> referenced by fscache.c
   >>> erofs/fscache.o:(erofs_init_fscache) in archive fs/built-in.a

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
