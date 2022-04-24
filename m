Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8482750D246
	for <lists+linux-erofs@lfdr.de>; Sun, 24 Apr 2022 16:32:02 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KmVvy3Jh9z3bYS
	for <lists+linux-erofs@lfdr.de>; Mon, 25 Apr 2022 00:31:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Q7Q7mA5M;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=intel.com (client-ip=192.55.52.93; helo=mga11.intel.com;
 envelope-from=lkp@intel.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=Q7Q7mA5M; dkim-atps=neutral
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KmVvs50Xwz2xgN
 for <linux-erofs@lists.ozlabs.org>; Mon, 25 Apr 2022 00:31:48 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1650810713; x=1682346713;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=1o4u4tcHj8GJHvMb2O8TmdCKH7Vu63K+AlpEAuoV8Qo=;
 b=Q7Q7mA5MA1m5Keh4QWIFhdjT9UtdVxTxRixLuaefceYjHB+bF6CngrXf
 2n0ISKdblf23ZSkb2it/dmxOvoJlmftO4F7AcFJugAm3L5YvCbitl4ixw
 6NQSzQnLUBgVF8iIIekscTLaFdUD4nJw8uCBXRzBzzPaR8uUHIZ52Vph5
 QRHujB8eV+8mkRxpICE/5Oachn5CTzYVxJ2oIDWlFnadCPDfohcXdK8Ek
 HDuLpfmolNRA7T+nDRC78qORVCYqueK9DcryyDstWZUsMWaMGw7dYOqn/
 XGXWAuYHQfiDWvSQEDC4O9RBGy0lKXGTJQFJ4lUhu/Q/mDOQ7as/Wt9B/ Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10326"; a="262647439"
X-IronPort-AV: E=Sophos;i="5.90,286,1643702400"; d="scan'208";a="262647439"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Apr 2022 07:30:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,286,1643702400"; d="scan'208";a="594855437"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
 by orsmga001.jf.intel.com with ESMTP; 24 Apr 2022 07:30:42 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
 (envelope-from <lkp@intel.com>) id 1nidG6-0001WV-0m;
 Sun, 24 Apr 2022 14:30:42 +0000
Date: Sun, 24 Apr 2022 22:30:34 +0800
From: kernel test robot <lkp@intel.com>
To: Hongnan Li <hongnan.li@linux.alibaba.com>, linux-erofs@lists.ozlabs.org,
 xiang@kernel.org, chao@kernel.org
Subject: Re: [PATCH] erofs: make filesystem exportable
Message-ID: <202204242236.0aTl5THK-lkp@intel.com>
References: <20220424130104.102365-1-hongnan.li@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220424130104.102365-1-hongnan.li@linux.alibaba.com>
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
Cc: llvm@lists.linux.dev, kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Hongnan,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on xiang-erofs/dev-test]
[also build test WARNING on v5.18-rc3 next-20220422]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Hongnan-Li/erofs-make-filesystem-exportable/20220424-211653
base:   https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git dev-test
config: hexagon-buildonly-randconfig-r005-20220424 (https://download.01.org/0day-ci/archive/20220424/202204242236.0aTl5THK-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 1cddcfdc3c683b393df1a5c9063252eb60e52818)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/c0fc15c5ccc4a5090cc32744ba63bde8ea558ac7
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Hongnan-Li/erofs-make-filesystem-exportable/20220424-211653
        git checkout c0fc15c5ccc4a5090cc32744ba63bde8ea558ac7
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash fs/erofs/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> fs/erofs/super.c:601:16: warning: no previous prototype for function 'erofs_get_parent' [-Wmissing-prototypes]
   struct dentry *erofs_get_parent(struct dentry *child)
                  ^
   fs/erofs/super.c:601:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   struct dentry *erofs_get_parent(struct dentry *child)
   ^
   static 
   1 warning generated.


vim +/erofs_get_parent +601 fs/erofs/super.c

   600	
 > 601	struct dentry *erofs_get_parent(struct dentry *child)
   602	{
   603		erofs_nid_t nid;
   604		unsigned int d_type;
   605		int err;
   606	
   607		err = erofs_namei(d_inode(child), &dotdot_name, &nid, &d_type);
   608		if (err)
   609			return ERR_PTR(err);
   610		return d_obtain_alias(erofs_iget(child->d_sb, nid, d_type == FT_DIR));
   611	}
   612	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
