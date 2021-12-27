Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id C16E848029B
	for <lists+linux-erofs@lfdr.de>; Mon, 27 Dec 2021 18:08:52 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4JN3zQ1pP4z2ynp
	for <lists+linux-erofs@lfdr.de>; Tue, 28 Dec 2021 04:08:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=VrSTBVo+;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=intel.com (client-ip=192.55.52.93; helo=mga11.intel.com;
 envelope-from=lkp@intel.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=VrSTBVo+; dkim-atps=neutral
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4JN3zJ0jN9z2yHZ
 for <linux-erofs@lists.ozlabs.org>; Tue, 28 Dec 2021 04:08:37 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1640624924; x=1672160924;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=nM84cc11HFk2HmUjcmlzoeZWzGPg6p3uhxB1YO8OS50=;
 b=VrSTBVo+spfYubdIt9QYIQAE8nADMp/RRejEaAc1lJu3+O9oEziOCA7r
 crmuQXma2eQdd+LqFx64P83NlJWhnf1jFoz39YEJrxWdsbcldBvk1/GFa
 Coj9c7wpzI/8hzymEA2H1VD8gdoF2rUqIu5nPmUWsUuHv/BJ7Lxi0vJuV
 qBS8KEnyg9cEVfTxWFyE6C4H4U+WmXbE4U9zVXmRwUzU9uj4iaj/h9Dvm
 2MHtcVwqLMi7z+ejfD0np4lw7acz4S3UA2Jk+moMUxsltDFHG+IJjmANF
 iAupoxq4HRRnCanZ/2MVrPXHLuUDj38C3fd/1C31MLCM0tJvKsdnFVnRO Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10210"; a="238777252"
X-IronPort-AV: E=Sophos;i="5.88,240,1635231600"; d="scan'208";a="238777252"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Dec 2021 09:07:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,240,1635231600"; d="scan'208";a="553852120"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
 by orsmga001.jf.intel.com with ESMTP; 27 Dec 2021 09:07:31 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1n1tT8-0006cY-B8; Mon, 27 Dec 2021 17:07:30 +0000
Date: Tue, 28 Dec 2021 01:07:25 +0800
From: kernel test robot <lkp@intel.com>
To: Jeffle Xu <jefflexu@linux.alibaba.com>, dhowells@redhat.com,
 linux-cachefs@redhat.com, xiang@kernel.org, chao@kernel.org,
 linux-erofs@lists.ozlabs.org
Subject: Re: [PATCH v1 12/23] erofs: implement fscache-based metadata read
Message-ID: <202112280115.O0H8Ow1Q-lkp@intel.com>
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
config: m68k-defconfig (https://download.01.org/0day-ci/archive/20211228/202112280115.O0H8Ow1Q-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/c3453b91df3b4e89c3336453437f761d6cb6bca3
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Jeffle-Xu/fscache-erofs-fscache-based-demand-read-semantics/20211227-205742
        git checkout c3453b91df3b4e89c3336453437f761d6cb6bca3
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=m68k SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

ERROR: modpost: "netfs_subreq_terminated" [fs/erofs/erofs.ko] undefined!
>> ERROR: modpost: "netfs_readpage" [fs/erofs/erofs.ko] undefined!

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
