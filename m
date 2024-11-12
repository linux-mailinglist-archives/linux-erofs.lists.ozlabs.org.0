Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA44A9C5AF4
	for <lists+linux-erofs@lfdr.de>; Tue, 12 Nov 2024 15:53:34 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XnqDD6ZQqz2yhM
	for <lists+linux-erofs@lfdr.de>; Wed, 13 Nov 2024 01:53:32 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.11
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1731423211;
	cv=none; b=anx+gw9xDsp78X5qwFkSB/fUX+y9VBPgVMM840xw6AwmQIYhaH0VFBDfTdoVFA9GA8tGRudQjS4EG8QU0My4bjUknWxUjLwqwn8BxFHYfQcqmi7FpMYUy4d1tLF2+HO/LyabMxga22GwMywQrJFUbe/JkP621Xh89I0nG39bKsfWo7ta+UIsX/WUnT7c2XZrSsZwMVgKVx8SYRUXqcbnuUxsRBd1EHi+sqBmRqwceidymOEKamMxJO+p0JwtWLkihxvgraOedm1up+5pGydPAkAA+icWYIZWR+N1joH4SC5H0HFUXkEsjZSj5uwjc8wMcz/RExSNLh52Nurv2E4kqw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1731423211; c=relaxed/relaxed;
	bh=RDQ44PN9j8AtWPN/uzGEubxnaiX4Hqp6rmZ20fygDtk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZXR7s7Vlo1/Hteoi7O2jokowUld2QwyGBnaviCFSPjY8kbna0jlmTkDxStXJHaT5BjqUQ3pOXlfQlaTj0OL4TsMIzpUkB6KeTv20wvLfZpDJD3rVdjqv3Vs1czCWMTB2FUihF47WLTQyRIFDCKeDCBxCKoyLCfrjMCVMwUZNQIAZK2VuggRENIgMcxl/BTAJbxwSs0aPMxNVacoQBWVQZOnBjUyHzyf+UurAykc6SEhTTzWVOrCd+hb7E4esJp3yscKH7rKLmuypeJGwglpJG+Dj9995ziWNzU4P6IO+6EpME+62e3dBVStvJiTI1DK2gOZ3JUV7trYd1OlyavzK/w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=lF+AQgjc; dkim-atps=neutral; spf=pass (client-ip=192.198.163.11; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=lF+AQgjc;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.198.163.11; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 64 seconds by postgrey-1.37 at boromir; Wed, 13 Nov 2024 01:53:29 AEDT
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XnqD90RgNz2xDl
	for <linux-erofs@lists.ozlabs.org>; Wed, 13 Nov 2024 01:53:28 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731423209; x=1762959209;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XxmjXbd3NELFVsWVdW6o2Zxqx8IqBr4HxPuGWI6cATE=;
  b=lF+AQgjctldTL/b/JWy9DS5WS8PerE5wPI6tSOhr14Kh+INUt9NG7wNt
   Y2z8yPIohRZddYJWIgDL4Nyg1yoU1swFyE0DXExfkh5NhtZFS4tU8+qGv
   +3kxyfStTqFzmIbv262SAlYU5ooQz1tby9+jhxF8NxiUdqF60R5abGand
   kZVcO/etO7O1Asa7j45Nl0ySnsOiYbekTYCxCeWFO6VoLfCXhorD3bqP9
   pJzXld62RrvVWMvwX19S4Ambmdm+dfr40ViGTLShCO1tZGf/G++GTKmCx
   Jgn+4Zb5hAQPaptlEe0I7LB05UXwY7tQ4JfubaxYbrhpA27Wdehu/xFGp
   Q==;
X-CSE-ConnectionGUID: E6GwO3TzTZOgQXzldWSCdQ==
X-CSE-MsgGUID: Jo4N5KA7RUO/l08OPGeEyQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11254"; a="41885684"
X-IronPort-AV: E=Sophos;i="6.12,148,1728975600"; 
   d="scan'208";a="41885684"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2024 06:52:20 -0800
X-CSE-ConnectionGUID: ckdD5CfLSzipX2yz0R4Ubw==
X-CSE-MsgGUID: f3iIhOODQomMGy2XCI5DuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,148,1728975600"; 
   d="scan'208";a="87259015"
Received: from lkp-server01.sh.intel.com (HELO bcfed0da017c) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 12 Nov 2024 06:52:17 -0800
Received: from kbuild by bcfed0da017c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tAsFb-0001RK-2e;
	Tue, 12 Nov 2024 14:52:15 +0000
Date: Tue, 12 Nov 2024 22:51:40 +0800
From: kernel test robot <lkp@intel.com>
To: Chunhai Guo <guochunhai@vivo.com>, xiang@kernel.org
Subject: Re: [PATCH] erofs: add sysfs node to drop all compression-related
 caches
Message-ID: <202411122209.OQ3CcFg1-lkp@intel.com>
References: <20241112091403.586545-1-guochunhai@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241112091403.586545-1-guochunhai@vivo.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_PASS autolearn=disabled version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org
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
Cc: linux-kernel@vger.kernel.org, huyue2@coolpad.com, oe-kbuild-all@lists.linux.dev, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Chunhai,

kernel test robot noticed the following build errors:

[auto build test ERROR on xiang-erofs/dev-test]
[also build test ERROR on xiang-erofs/dev xiang-erofs/fixes linus/master v6.12-rc7 next-20241112]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Chunhai-Guo/erofs-add-sysfs-node-to-drop-all-compression-related-caches/20241112-170412
base:   https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git dev-test
patch link:    https://lore.kernel.org/r/20241112091403.586545-1-guochunhai%40vivo.com
patch subject: [PATCH] erofs: add sysfs node to drop all compression-related caches
config: x86_64-randconfig-161-20241112 (https://download.01.org/0day-ci/archive/20241112/202411122209.OQ3CcFg1-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241112/202411122209.OQ3CcFg1-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411122209.OQ3CcFg1-lkp@intel.com/

All errors (new ones prefixed by >>):

   fs/erofs/sysfs.c: In function 'erofs_attr_store':
>> fs/erofs/sysfs.c:175:17: error: implicit declaration of function 'z_erofs_shrink_scan' [-Werror=implicit-function-declaration]
     175 |                 z_erofs_shrink_scan(sbi, ~0UL);
         |                 ^~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/z_erofs_shrink_scan +175 fs/erofs/sysfs.c

   132	
   133	static ssize_t erofs_attr_store(struct kobject *kobj, struct attribute *attr,
   134							const char *buf, size_t len)
   135	{
   136		struct erofs_sb_info *sbi = container_of(kobj, struct erofs_sb_info,
   137							s_kobj);
   138		struct erofs_attr *a = container_of(attr, struct erofs_attr, attr);
   139		unsigned char *ptr = __struct_ptr(sbi, a->struct_type, a->offset);
   140		unsigned long t;
   141		int ret;
   142	
   143		switch (a->attr_id) {
   144		case attr_pointer_ui:
   145			if (!ptr)
   146				return 0;
   147			ret = kstrtoul(skip_spaces(buf), 0, &t);
   148			if (ret)
   149				return ret;
   150			if (t != (unsigned int)t)
   151				return -ERANGE;
   152	#ifdef CONFIG_EROFS_FS_ZIP
   153			if (!strcmp(a->attr.name, "sync_decompress") &&
   154			    (t > EROFS_SYNC_DECOMPRESS_FORCE_OFF))
   155				return -EINVAL;
   156	#endif
   157			*(unsigned int *)ptr = t;
   158			return len;
   159		case attr_pointer_bool:
   160			if (!ptr)
   161				return 0;
   162			ret = kstrtoul(skip_spaces(buf), 0, &t);
   163			if (ret)
   164				return ret;
   165			if (t != 0 && t != 1)
   166				return -EINVAL;
   167			*(bool *)ptr = !!t;
   168			return len;
   169		case attr_drop_caches:
   170			ret = kstrtoul(skip_spaces(buf), 0, &t);
   171			if (ret)
   172				return ret;
   173			if (t != 1)
   174				return -EINVAL;
 > 175			z_erofs_shrink_scan(sbi, ~0UL);
   176			return len;
   177		}
   178		return 0;
   179	}
   180	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
