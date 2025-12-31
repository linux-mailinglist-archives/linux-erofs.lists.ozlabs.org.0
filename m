Return-Path: <linux-erofs+bounces-1656-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47C09CEB236
	for <lists+linux-erofs@lfdr.de>; Wed, 31 Dec 2025 03:59:21 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dgvmz5R6yz2yFQ;
	Wed, 31 Dec 2025 13:59:15 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.18
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1767149955;
	cv=none; b=ZW+6S1I5My9Q99q1Nfzh+2mmmju37JLVXsaSxNsmAayjPcxTsLK8nUUbLN7WTJTqbAioAoVSBbjTyeYsSBcLur2mVlEJ7nqgh+GP2+dF/5ObmjGyb9aLLZOBosNh3nllZn8fklDyg8QTFy8qVX91RpbPe8kB4q+aS3zttwB97U+quLNT1QdU+aIOsVK+OZjt82z+EHqUfgxgPgOnLOGVVsuxIQPcii+q3iST65l8ozjmSGz3vHC9y7vS0yz+8jsOjR8T533DpXFf1nXAnIMKmzsSke3N+L0thm3AfzuPX6Ay72MAd5qAVKqOjC6fVIikJFPZNBREkGci1FLTsTDwvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1767149955; c=relaxed/relaxed;
	bh=16aQyxtAd02F1Mdoh2ZO9b7NTeRamdnlW7AUqOCTOUg=;
	h=Date:From:To:Cc:Subject:Message-ID; b=WgYf5bLFhZX8LwZP8sl+9SEsRE/fma+4c0ecY8nkZaVx9xr0kNZa4KJ0oXXcEJdxRz2mkzw4x8M44LQnYYSXpwsGwNbw8xp9H5I/k4kwwvhkDodi/WcItKDo/hbZO5YKakobrwt7rV7WcJFrltZuJuSzwq10ugkuURBZX/YUsRmqcJ3owaYJyp/JLpnrb5Tf/TpkCDy/Iy4SHYjtnUt8cSfU8edheYnUrFRLfIgbSQ32l4wxMRqr5sbhmpGAnzbmuiSTLbq5Swsl0kpfolcAB+l99AIc9GZdUSu+O0+9feVhUlrvBRmTy3FuPlOMmW4Vy/+9dTuNJJlPrf2ZaQx8ew==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=drV7IbUN; dkim-atps=neutral; spf=pass (client-ip=198.175.65.18; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=drV7IbUN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=198.175.65.18; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dgvmw5sWZz2xS6
	for <linux-erofs@lists.ozlabs.org>; Wed, 31 Dec 2025 13:59:10 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767149953; x=1798685953;
  h=date:from:to:cc:subject:message-id;
  bh=sGt+DcrzYB9BBdvBwj2TeJKu/Icze4Ak8M3LwrotN7A=;
  b=drV7IbUNeohOr78vPPyJA2GEiBwRyYtSu0j2TcQqUWSplxnub2HIIkYO
   Jsg6aO+3nrjOK82XSuHvsT3oBWNDWI8xCoeHGIrdrJnx6O+PoV8W+Oeaq
   bP80LJdckPBGv56OigZPWFXd+6TH7Yhgk9ZZy3uCalBBROnF47rDbYLW0
   wGE3NLA2YyXR7zK679OdSC5JaaCfkyJeTyDV9CtdKlkGsM+UxlyLKxTXa
   cqkXzFuuR1eZNftE5KNH5jmW3xP7N/2UKOP4HCcYCeKDg8//aGdACF4GY
   L1b4St/laq2eQXDLKzzWgbbAZldy466qRF11DPQ//e4QQau/zhmJiIc2U
   A==;
X-CSE-ConnectionGUID: 2bvytuWHTLuuq44Qkb4wSA==
X-CSE-MsgGUID: npApRsOCRT+DN8h6eOTNrQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11657"; a="68773231"
X-IronPort-AV: E=Sophos;i="6.21,190,1763452800"; 
   d="scan'208";a="68773231"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Dec 2025 18:59:06 -0800
X-CSE-ConnectionGUID: gR4T+CYASdm+c7G+70sNJw==
X-CSE-MsgGUID: wb4q+bq4Q0OPsj6VQbQssw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,190,1763452800"; 
   d="scan'208";a="201094700"
Received: from lkp-server01.sh.intel.com (HELO c9aa31daaa89) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 30 Dec 2025 18:59:05 -0800
Received: from kbuild by c9aa31daaa89 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vamQP-000000000tl-3m1w;
	Wed, 31 Dec 2025 02:59:01 +0000
Date: Wed, 31 Dec 2025 10:59:01 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: oe-kbuild-all@lists.linux.dev, Xiang Gao <xiang@kernel.org>,
 linux-erofs@lists.ozlabs.org, Hongbo Li <lihongbo22@huawei.com>
Subject: [xiang-erofs:dev-test 9/10] fs/erofs/xattr.c:451:43: sparse:
 sparse: symbol 'erofs_xattr_security_handler' was not declared. Should it be
 static?
Message-ID: <202512311021.L0IMtTOh-lkp@intel.com>
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
config: arm-randconfig-r113-20251231 (https://download.01.org/0day-ci/archive/20251231/202512311021.L0IMtTOh-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 86b9f90b9574b3a7d15d28a91f6316459dcfa046)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251231/202512311021.L0IMtTOh-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202512311021.L0IMtTOh-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   fs/erofs/xattr.c:436:28: sparse: sparse: symbol 'erofs_xattr_user_handler' was not declared. Should it be static?
   fs/erofs/xattr.c:443:28: sparse: sparse: symbol 'erofs_xattr_trusted_handler' was not declared. Should it be static?
>> fs/erofs/xattr.c:451:43: sparse: sparse: symbol 'erofs_xattr_security_handler' was not declared. Should it be static?

vim +/erofs_xattr_security_handler +451 fs/erofs/xattr.c

89d806805778053 Gao Xiang 2025-12-29  449  
89d806805778053 Gao Xiang 2025-12-29  450  #ifdef CONFIG_EROFS_FS_SECURITY
89d806805778053 Gao Xiang 2025-12-29 @451  const struct xattr_handler __maybe_unused erofs_xattr_security_handler = {
89d806805778053 Gao Xiang 2025-12-29  452  	.prefix	= XATTR_SECURITY_PREFIX,
89d806805778053 Gao Xiang 2025-12-29  453  	.flags	= EROFS_XATTR_INDEX_SECURITY,
89d806805778053 Gao Xiang 2025-12-29  454  	.get	= erofs_xattr_generic_get,
89d806805778053 Gao Xiang 2025-12-29  455  };
89d806805778053 Gao Xiang 2025-12-29  456  #endif
89d806805778053 Gao Xiang 2025-12-29  457  

:::::: The code at line 451 was first introduced by commit
:::::: 89d8068057780531fab06b928a80599b9762e461 erofs: unexport erofs_getxattr()

:::::: TO: Gao Xiang <hsiangkao@linux.alibaba.com>
:::::: CC: Gao Xiang <hsiangkao@linux.alibaba.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

