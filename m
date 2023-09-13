Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 87FAC79DD32
	for <lists+linux-erofs@lfdr.de>; Wed, 13 Sep 2023 02:39:12 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RlhQw6Bn1z3dVx
	for <lists+linux-erofs@lfdr.de>; Wed, 13 Sep 2023 10:39:04 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RlhQn3kNHz3dVN
	for <linux-erofs@lists.ozlabs.org>; Wed, 13 Sep 2023 10:38:55 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0VryHc6B_1694565526;
Received: from 192.168.3.4(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VryHc6B_1694565526)
          by smtp.aliyun-inc.com;
          Wed, 13 Sep 2023 08:38:48 +0800
Message-ID: <7f11496e-ef18-1dcd-bd85-68663531f50d@linux.alibaba.com>
Date: Wed, 13 Sep 2023 08:38:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: kernel BUG in erofs_iget
To: Sanan Hasanov <Sanan.Hasanov@ucf.edu>, "xiang@kernel.org"
 <xiang@kernel.org>, "chao@kernel.org" <chao@kernel.org>,
 "huyue2@coolpad.com" <huyue2@coolpad.com>,
 "jefflexu@linux.alibaba.com" <jefflexu@linux.alibaba.com>,
 "linux-erofs@lists.ozlabs.org" <linux-erofs@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <BL0PR11MB3106CA52AA8E2978AF2756B6E1EEA@BL0PR11MB3106.namprd11.prod.outlook.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <BL0PR11MB3106CA52AA8E2978AF2756B6E1EEA@BL0PR11MB3106.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
Cc: "syzkaller@googlegroups.com" <syzkaller@googlegroups.com>, "contact@pgazz.com" <contact@pgazz.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2023/9/13 07:02, Sanan Hasanov wrote:
> Good day, dear maintainers,
> 
> We found a bug using a modified kernel configuration file used by syzbot.
> 
> We enhanced the coverage of the configuration file using our tool, klocalizer.

1) Please don't enable CONFIG_EROFS_FS_DEBUG=y when fuzzing.  This configuration
    is just for developper debugging, not for daily use or fuzzing.

2) Please don't use random -next version, I don't even find this version in
    https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/refs/tags
    now.  Although it seems

198 bogusimode:
199 	erofs_err(inode->i_sb, "bogus i_mode (%o) @ nid %llu",
200 		  inode->i_mode, vi->nid);
201 	err = -EFSCORRUPTED;
202 err_out:
203>	DBG_BUGON(1);
204 	kfree(copied);
205 	erofs_put_metabuf(buf);
206 	return ERR_PTR(err);

    when I check Linux v6.3 source code.  Please use upstream or latest tree for
    fuzzing, thanks!

Thanks,
Gao Xiang

> 
> Kernel Branch: 6.3.0-next-20230426
> Kernel Config: https://drive.google.com/file/d/1rGIKWTEfoMed0JL5jWFws4GJ0VNSVgw8/view?usp=sharing
> Reproducer: https://drive.google.com/file/d/1ceAFcx9hhevq_ivDNPkXmEGYsr26yB4N/view?usp=sharing
> Thank you!
> 
> Best regards,
> Sanan Hasanov
> 
