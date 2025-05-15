Return-Path: <linux-erofs+bounces-324-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 87051AB7BD7
	for <lists+linux-erofs@lfdr.de>; Thu, 15 May 2025 04:59:56 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZyZgs3tgzz2yvv;
	Thu, 15 May 2025 12:59:53 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.9
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1747277993;
	cv=none; b=jCxkDuwDa10qFYE4FsDCVIdfx956LaN8LCg6oGte4h86r5mEIuJpP067DxYpkMqO20edEasjyZbM5krxsb2qPMCGklofMMsS0lmg7Ld6pKYI2r5WGuJM90n5uTNFho/a1+Ld6VpuRLJjCuxpFa2GHJxx6eQCQHu+dOrIoa6L1DbEKv4h5GbtxwFc5gr0SDv27GV+f1pA5BNtTc7XztDNELMDDG2IKe67V9GbIbCe/NSQ55wpQqetlMXmr3c3NZcaPAp5m4AoyMKEa9fuCcPnkwqU/BLnpKQxatNzgDJ2rUVBxMz5wWcf0hErUx7RBZAQEVTcAJzLRyRtftGrhAX1Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1747277993; c=relaxed/relaxed;
	bh=7yqC/BLEsCKDAJti4za1VZ8DVDx0SS2Hwaa0jQmuHLk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HhZG9Gfbf+SF2BsJpXZinQ3YAQovq7v4HaD4MijrZgPnDw09NIfLm2H7X4ktGuUQMUiw0pTyJv0+0m116NNNsTzSULeSrtnOMmgwWim8JYg6ak6O71bF21D06BDBbK0R7AhTurYmaHe1DNmKM9YvEutorUI0rDP4Dn1lD50K54eYk5GkvM9tWHwEk8dL1hWqFpQ/0wOrzWB1yv9dxp4ZQj90NpAGC3FEMm9ggQ8iO+xHooheusZ4dB3T30PlVVpAJaKhZy3CTtc6xkQR2FLa3EE7d7Gct7IiqIOIDYAaHedC09J0i2ZgBi8unuALrLKbk+TN5ao5qxtjEqVppsqYng==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=B4mek76B; dkim-atps=neutral; spf=pass (client-ip=192.198.163.9; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=B4mek76B;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.198.163.9; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZyZgq0sjvz2yvk
	for <linux-erofs@lists.ozlabs.org>; Thu, 15 May 2025 12:59:49 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747277991; x=1778813991;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HsfreBSPTaUwvPo+a+UW0RwvFkDmhpcCnMej2+zMrZo=;
  b=B4mek76BQlG2wcz08RsseVj9G5Ao7G56wIHv57iq3qeN/gfzBu7Qmfwd
   rYwdheqyHKLc/JKm+RzrtYcmXrewuurm5NijSaae5qIov2dNBxfyH719d
   za1D71vS86A4BSKxe0R+w5wC8e/J8FgOrfA2qm/4P64ibkvkvI3wzAnTk
   Y8VqWWOrb8DfXxCmJkQuKL9gSNZDNhVKn3WsR2sykh/ZMJG1vpbnHv1EM
   I8JhwV+8cp3o3XETkFtPbc/HW7fGFTh1QfqhPLtvs+ZY8EV3lCpX5OzMk
   Bz6li6oH5T8V6DIgRjr5JcQ3e1hrA/Ak4xBh5eInMAMtYq9t+rBHw9T1J
   g==;
X-CSE-ConnectionGUID: DeKw5TPERTmHFnC4K8MQCw==
X-CSE-MsgGUID: fUcEzQlVSauchBrKMwX3YQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11433"; a="59850501"
X-IronPort-AV: E=Sophos;i="6.15,289,1739865600"; 
   d="scan'208";a="59850501"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2025 19:59:47 -0700
X-CSE-ConnectionGUID: 3bTV9dubTkq3H46JE5s/ZA==
X-CSE-MsgGUID: 1nGSZBhDR2+oUzrzoyHjfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,289,1739865600"; 
   d="scan'208";a="175363445"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 14 May 2025 19:59:45 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uFOow-000Hnz-2S;
	Thu, 15 May 2025 02:59:42 +0000
Date: Thu, 15 May 2025 10:59:02 +0800
From: kernel test robot <lkp@intel.com>
To: Bo Liu <liubo03@inspur.com>, xiang@kernel.org, chao@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, linux-erofs@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, Bo Liu <liubo03@inspur.com>
Subject: Re: [PATCH v2] erofs: support deflate decompress by using Intel QAT
Message-ID: <202505151023.ond6cMbi-lkp@intel.com>
References: <20250514121709.2557-1-liubo03@inspur.com>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250514121709.2557-1-liubo03@inspur.com>
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Hi Bo,

kernel test robot noticed the following build errors:

[auto build test ERROR on xiang-erofs/dev-test]
[also build test ERROR on xiang-erofs/dev xiang-erofs/fixes linus/master v6.15-rc6 next-20250514]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Bo-Liu/erofs-support-deflate-decompress-by-using-Intel-QAT/20250514-202351
base:   https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git dev-test
patch link:    https://lore.kernel.org/r/20250514121709.2557-1-liubo03%40inspur.com
patch subject: [PATCH v2] erofs: support deflate decompress by using Intel QAT
config: x86_64-rhel-9.4 (https://download.01.org/0day-ci/archive/20250515/202505151023.ond6cMbi-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250515/202505151023.ond6cMbi-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505151023.ond6cMbi-lkp@intel.com/

All errors (new ones prefixed by >>):

>> fs/erofs/sysfs.c:60:27: error: 'erofs_attr_crypto_enable' undeclared here (not in a function); did you mean 'attr_crypto_enable'?
      60 | #define ATTR_LIST(name) (&erofs_attr_##name.attr)
         |                           ^~~~~~~~~~~
   fs/erofs/sysfs.c:103:9: note: in expansion of macro 'ATTR_LIST'
     103 |         ATTR_LIST(crypto_enable),
         |         ^~~~~~~~~
>> fs/erofs/sysfs.c:60:27: error: 'erofs_attr_crypto_disable' undeclared here (not in a function); did you mean 'attr_crypto_disable'?
      60 | #define ATTR_LIST(name) (&erofs_attr_##name.attr)
         |                           ^~~~~~~~~~~
   fs/erofs/sysfs.c:104:9: note: in expansion of macro 'ATTR_LIST'
     104 |         ATTR_LIST(crypto_disable),
         |         ^~~~~~~~~


vim +60 fs/erofs/sysfs.c

168e9a76200c54 Huang Jianan 2021-12-01  47  
168e9a76200c54 Huang Jianan 2021-12-01  48  #define EROFS_ATTR_RW(_name, _id, _struct)	\
168e9a76200c54 Huang Jianan 2021-12-01  49  	EROFS_ATTR_OFFSET(_name, 0644, _id, _struct)
168e9a76200c54 Huang Jianan 2021-12-01  50  
168e9a76200c54 Huang Jianan 2021-12-01  51  #define EROFS_RO_ATTR(_name, _id, _struct)	\
168e9a76200c54 Huang Jianan 2021-12-01  52  	EROFS_ATTR_OFFSET(_name, 0444, _id, _struct)
168e9a76200c54 Huang Jianan 2021-12-01  53  
168e9a76200c54 Huang Jianan 2021-12-01  54  #define EROFS_ATTR_RW_UI(_name, _struct)	\
168e9a76200c54 Huang Jianan 2021-12-01  55  	EROFS_ATTR_RW(_name, pointer_ui, _struct)
168e9a76200c54 Huang Jianan 2021-12-01  56  
168e9a76200c54 Huang Jianan 2021-12-01  57  #define EROFS_ATTR_RW_BOOL(_name, _struct)	\
168e9a76200c54 Huang Jianan 2021-12-01  58  	EROFS_ATTR_RW(_name, pointer_bool, _struct)
168e9a76200c54 Huang Jianan 2021-12-01  59  
168e9a76200c54 Huang Jianan 2021-12-01 @60  #define ATTR_LIST(name) (&erofs_attr_##name.attr)
168e9a76200c54 Huang Jianan 2021-12-01  61  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

