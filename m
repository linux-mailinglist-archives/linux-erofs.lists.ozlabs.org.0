Return-Path: <linux-erofs+bounces-193-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 36987A8542C
	for <lists+linux-erofs@lfdr.de>; Fri, 11 Apr 2025 08:32:17 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZYn00613Vz2yf7;
	Fri, 11 Apr 2025 16:31:44 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.9
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1744353104;
	cv=none; b=jlZCkTBoP3zKzrHARySnceqfUVPpZF8+NiS4k6dVcpiWbOPz80IxUgZjcrV97hi0U+F0eCUbfgm9AOL+1FV04YEeJEJTBrXpQHrmgFm4PEA2t5+JNagioPnl6H757NmknriZe9UWWewpmfQEHgJUNNZt/N00w55J+9c7d04HQJf42m/iUyRo3xj40pjCX8DPTfSgQCx4y+G7tVDx56sWTev2qnSW1WoAgGcexzgsXacUA3NWEHKbCqDSbNcN/AVRJUig975GM5pFoM+Xscfys0Gy3tLSaNGGsKoUuKYl8cRDEj2ex7iGhy2ZxUxhw/6SJSeQgu/b1lU+OTXl/JLgcw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1744353104; c=relaxed/relaxed;
	bh=qDFr6njFY0zs8ximtjz3OXRse/riz3MaKbsTvEi/pWw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HgF9rgS6NJr+aTZwAqVe+pGW2IYuM953G4J9n7z5tAOaQL74vvEEuKJwDbNKLuBCgG38sa3EKr6ny8LrSyXRKsdx/S+Vx+oO/Z5f/P93X7r/rN5buPUmIlePS/GFhqbbAnvJLgrkVmXrM6Q8ZdJBK49JinUXlv8IZoCiaFd+NIvtdfq3Zrk85ac+pXdxbVZdfv1UvtqK1GoimpdmHgFp7rOjPrZ+A0Bgs4isuRD0DFyJ6x2eHgguo06M9G2hULQNcLetNCV/DVOFbxGdUpaYcZcDUv6Ya+qMos/iBfol6M/Pz80FYwqQGwm9AOXMbKHKD+B85f/4IBdMMDgfLdEjmw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=NBO0v6Rc; dkim-atps=neutral; spf=pass (client-ip=198.175.65.9; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=NBO0v6Rc;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=198.175.65.9; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZYmzy2rsXz2ydw
	for <linux-erofs@lists.ozlabs.org>; Fri, 11 Apr 2025 16:31:40 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744353103; x=1775889103;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gPbW4hxtFr5Vb/hEwyhC++dCtSsKBgR/5ZNQcAMJ4IQ=;
  b=NBO0v6Rc0zmKubhxGqI+JOm9rRxJ4Lpt+/P1hDSac02CKOytpoylTeHU
   IYstsGjUK2t6XewTOzxET2wMjrhtaIBf7iV0ftfxesXqbs105rrOt5YIT
   8870XZahRpR1TBxHa3BOjU/v5NWm5JaaD0EDl/tIlGzXy27Gelk3zRrp6
   aOkoURVclapIOfa9FwGlsjT1SrdVWDZn2MQs+86TVni5CtEbjrfHpnxzK
   5scLQAo1cMz2zzW4Zb1iZNkSdi/ZSFNaC6QCTtm43m3xY0ll/+/cvkFZ6
   gM5iWr6k5rIApMSPTlLwbfyHJtPoIMO3OW5FiVySp7zwU3fR7HGWn2+CQ
   A==;
X-CSE-ConnectionGUID: BlzJx149QD2/jl0j60WrBg==
X-CSE-MsgGUID: sD/k/Px+Tee1P9MBBFKswQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11400"; a="68380986"
X-IronPort-AV: E=Sophos;i="6.15,203,1739865600"; 
   d="scan'208";a="68380986"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2025 23:31:38 -0700
X-CSE-ConnectionGUID: wMz7CBueRzm/tXRadmdZxg==
X-CSE-MsgGUID: P495+6TITKaP+RPdOXk7hw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,203,1739865600"; 
   d="scan'208";a="134272881"
Received: from lkp-server01.sh.intel.com (HELO b207828170a5) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 10 Apr 2025 23:31:36 -0700
Received: from kbuild by b207828170a5 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1u37vK-000Ati-0N;
	Fri, 11 Apr 2025 06:31:34 +0000
Date: Fri, 11 Apr 2025 14:30:46 +0800
From: kernel test robot <lkp@intel.com>
To: Bo Liu <liubo03@inspur.com>, xiang@kernel.org, chao@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, linux-erofs@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, Bo Liu <liubo03@inspur.com>
Subject: Re: [PATCH 2/2] erofs: support deflate decompress by using Intel QAT
Message-ID: <202504111440.2DIupC2G-lkp@intel.com>
References: <20250410042048.3044-3-liubo03@inspur.com>
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250410042048.3044-3-liubo03@inspur.com>
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Hi Bo,

kernel test robot noticed the following build errors:

[auto build test ERROR on xiang-erofs/dev-test]
[also build test ERROR on xiang-erofs/dev linus/master v6.15-rc1 next-20250410]
[cannot apply to xiang-erofs/fixes]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Bo-Liu/erofs-remove-duplicate-code/20250410-122442
base:   https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git dev-test
patch link:    https://lore.kernel.org/r/20250410042048.3044-3-liubo03%40inspur.com
patch subject: [PATCH 2/2] erofs: support deflate decompress by using Intel QAT
config: arc-randconfig-001-20250411 (https://download.01.org/0day-ci/archive/20250411/202504111440.2DIupC2G-lkp@intel.com/config)
compiler: arc-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250411/202504111440.2DIupC2G-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202504111440.2DIupC2G-lkp@intel.com/

All errors (new ones prefixed by >>):

   fs/erofs/sysfs.c: In function 'erofs_attr_show':
>> fs/erofs/sysfs.c:136:24: error: 'struct erofs_sb_info' has no member named 'erofs_tfm'
     136 |                 if (sbi->erofs_tfm)
         |                        ^~
   fs/erofs/sysfs.c:138:59: error: 'struct erofs_sb_info' has no member named 'erofs_tfm'
     138 |                                 crypto_comp_alg_common(sbi->erofs_tfm)->base.cra_driver_name);
         |                                                           ^~


vim +136 fs/erofs/sysfs.c

   115	
   116	static ssize_t erofs_attr_show(struct kobject *kobj,
   117					struct attribute *attr, char *buf)
   118	{
   119		struct erofs_sb_info *sbi = container_of(kobj, struct erofs_sb_info,
   120							s_kobj);
   121		struct erofs_attr *a = container_of(attr, struct erofs_attr, attr);
   122		unsigned char *ptr = __struct_ptr(sbi, a->struct_type, a->offset);
   123	
   124		switch (a->attr_id) {
   125		case attr_feature:
   126			return sysfs_emit(buf, "supported\n");
   127		case attr_pointer_ui:
   128			if (!ptr)
   129				return 0;
   130			return sysfs_emit(buf, "%u\n", *(unsigned int *)ptr);
   131		case attr_pointer_bool:
   132			if (!ptr)
   133				return 0;
   134			return sysfs_emit(buf, "%d\n", *(bool *)ptr);
   135		case attr_comp_crypto:
 > 136			if (sbi->erofs_tfm)
   137				return sysfs_emit(buf, "%s\n",
   138					crypto_comp_alg_common(sbi->erofs_tfm)->base.cra_driver_name);
   139			else
   140				return sysfs_emit(buf, "NONE\n");
   141		}
   142		return 0;
   143	}
   144	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

