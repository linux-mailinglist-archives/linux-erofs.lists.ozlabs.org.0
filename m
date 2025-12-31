Return-Path: <linux-erofs+bounces-1658-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD978CEB9EC
	for <lists+linux-erofs@lfdr.de>; Wed, 31 Dec 2025 10:03:43 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dh3sS05Vbz2yMJ;
	Wed, 31 Dec 2025 20:03:40 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.11
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1767171819;
	cv=none; b=h6O9WTuLwyv9kgcA4AOCS/+dCMa1vED/tiTnwqc6FE+fIkp5O6eRa7EctnpuoWab0Y1Im7tfS6QfFJRF0NSnQhMypBhUZ7BNn2bCqi3BZB1gktEMLp0THEcWaRlgueTWUXzxfDyu4gF51XDmhB1q4BxXIfSirnY75PFV+BiTX6bQpBQWLKhJ3w3U913k3d4x8/mB6bEyjCrVPjTO7/xg6f0jYHWVmmrawPE20vYpIp1pcvygLINZPJ7KrWofHkbYB1MP2mksuNYTiQVARfsdjceRFUbDg37xOd7MtddMWtk8yw8TNIQgknn+IcZGDBwoXxw9BbAe9/TLxJAuYBK+EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1767171819; c=relaxed/relaxed;
	bh=gt9+exgtTKQk8Vqaw7Kx+bVjLJyqkmr1GwLxM+Kt9TY=;
	h=Date:From:To:Cc:Subject:Message-ID; b=PmusiUd+U7lrF5mYgEwbFLMUeq6DcHfy7LwYk+yte7ZGhl3v19qKVsneuxpc3z2nzGKrMQvThrBqITxXLh6/2YPMEDu/hIWYaQGEBNq5CKyFapau1PqIRM0u96ErNLXm8jE62L68uBHHfeQNBHmRMK9X9GTyknMAPPkb+IRW+g15GgOluNZnrwHAN1XcMxZ1LKmNNRKoFCwHGCPQOj7/WJvVZaPizOes+l2MAZvlzmP117OkR0xUzqJYOCJUYRtP7iGSpDjrvXFn7y9174awKtjk6c6lfoIrQ+hdKQ6MN93Q1XnFkRlS5RAKlHk77pJpk05j32HxJQMaS/y0PscT9Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=SN8Nf9sD; dkim-atps=neutral; spf=pass (client-ip=192.198.163.11; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=SN8Nf9sD;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.198.163.11; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dh3sP0vzMz2yKr
	for <linux-erofs@lists.ozlabs.org>; Wed, 31 Dec 2025 20:03:35 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767171818; x=1798707818;
  h=date:from:to:cc:subject:message-id;
  bh=eyC+EaIJcFLoGtVsvy0LMRUhjmrMkTRf1e+PAR7E5GU=;
  b=SN8Nf9sDQDe9+C8WkNFRz9YQEtVR09Ip+mIHCOep/b0VRftSNyKiFXKr
   12Gkf8yuN9XQu31q2IX64aozvfbzinmG9waa5JemftNhne9xVtMFY5Eqq
   zF5Dl6G7Qcn4zuCEmCUE0XkJXW1waHI2uOXJpw+uwi4uwbbEAYEPLGlcl
   NuiUFE5Zqp0JKopOv/MbBEtIhq33tTH9TjUNoPx1UqPg+ee2AgisI2N0v
   58PsBjb99i9h9RtYiM8x45yPdM12DxLRCS9Yeh6lEfRhbh39qdcAVl6K0
   cNZ7CO/1KPleAyLHZnNgtgjRftTfWB3pVP/d0NefteptpaywZAzPTseNx
   w==;
X-CSE-ConnectionGUID: Ez+JyWuhTS6w8siW4oOH9A==
X-CSE-MsgGUID: hPImKjDGRiyemUEvWXMYdg==
X-IronPort-AV: E=McAfee;i="6800,10657,11657"; a="79375800"
X-IronPort-AV: E=Sophos;i="6.21,191,1763452800"; 
   d="scan'208";a="79375800"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Dec 2025 01:03:30 -0800
X-CSE-ConnectionGUID: xHANxmJDSx6eY9SDlJaE6A==
X-CSE-MsgGUID: ganwjXm5SkerrEadfxtP1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,191,1763452800"; 
   d="scan'208";a="201408726"
Received: from lkp-server01.sh.intel.com (HELO c9aa31daaa89) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 31 Dec 2025 01:03:28 -0800
Received: from kbuild by c9aa31daaa89 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vas73-0000000014K-44e5;
	Wed, 31 Dec 2025 09:03:25 +0000
Date: Wed, 31 Dec 2025 17:02:48 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: oe-kbuild-all@lists.linux.dev, Xiang Gao <xiang@kernel.org>,
 linux-erofs@lists.ozlabs.org, Hongbo Li <lihongbo22@huawei.com>
Subject: [xiang-erofs:dev-test 9/10] fs/erofs/xattr.c:436:28: sparse:
 sparse: symbol 'erofs_xattr_user_handler' was not declared. Should it be
 static?
Message-ID: <202512311706.lMHnw10m-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git dev-test
head:   e84fd1bdbe05e6b3ebe5766b98b7e4902203e8e1
commit: cb6528654a7fb2a3ffd55889fc877f61ca72edda [9/10] erofs: unexport erofs_xattr_prefix()
config: sh-randconfig-r134-20251231 (https://download.01.org/0day-ci/archive/20251231/202512311706.lMHnw10m-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 9.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251231/202512311706.lMHnw10m-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202512311706.lMHnw10m-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> fs/erofs/xattr.c:436:28: sparse: sparse: symbol 'erofs_xattr_user_handler' was not declared. Should it be static?
>> fs/erofs/xattr.c:443:28: sparse: sparse: symbol 'erofs_xattr_trusted_handler' was not declared. Should it be static?

vim +/erofs_xattr_user_handler +436 fs/erofs/xattr.c

89d80680577805 Gao Xiang 2025-12-29  435  
89d80680577805 Gao Xiang 2025-12-29 @436  const struct xattr_handler erofs_xattr_user_handler = {
89d80680577805 Gao Xiang 2025-12-29  437  	.prefix	= XATTR_USER_PREFIX,
89d80680577805 Gao Xiang 2025-12-29  438  	.flags	= EROFS_XATTR_INDEX_USER,
89d80680577805 Gao Xiang 2025-12-29  439  	.list	= erofs_xattr_user_list,
89d80680577805 Gao Xiang 2025-12-29  440  	.get	= erofs_xattr_generic_get,
89d80680577805 Gao Xiang 2025-12-29  441  };
89d80680577805 Gao Xiang 2025-12-29  442  
89d80680577805 Gao Xiang 2025-12-29 @443  const struct xattr_handler erofs_xattr_trusted_handler = {
89d80680577805 Gao Xiang 2025-12-29  444  	.prefix	= XATTR_TRUSTED_PREFIX,
89d80680577805 Gao Xiang 2025-12-29  445  	.flags	= EROFS_XATTR_INDEX_TRUSTED,
89d80680577805 Gao Xiang 2025-12-29  446  	.list	= erofs_xattr_trusted_list,
89d80680577805 Gao Xiang 2025-12-29  447  	.get	= erofs_xattr_generic_get,
89d80680577805 Gao Xiang 2025-12-29  448  };
89d80680577805 Gao Xiang 2025-12-29  449  

:::::: The code at line 436 was first introduced by commit
:::::: 89d8068057780531fab06b928a80599b9762e461 erofs: unexport erofs_getxattr()

:::::: TO: Gao Xiang <hsiangkao@linux.alibaba.com>
:::::: CC: Gao Xiang <hsiangkao@linux.alibaba.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

