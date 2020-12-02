Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D23812CB9E7
	for <lists+linux-erofs@lfdr.de>; Wed,  2 Dec 2020 10:59:43 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CmDwF0VzWzDr3Y
	for <lists+linux-erofs@lfdr.de>; Wed,  2 Dec 2020 20:59:41 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::532;
 helo=mail-pg1-x532.google.com; envelope-from=zbestahu@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=YvFQOzpx; dkim-atps=neutral
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com
 [IPv6:2607:f8b0:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CmDw61CxhzDr0K
 for <linux-erofs@lists.ozlabs.org>; Wed,  2 Dec 2020 20:59:33 +1100 (AEDT)
Received: by mail-pg1-x532.google.com with SMTP id i38so721464pgb.5
 for <linux-erofs@lists.ozlabs.org>; Wed, 02 Dec 2020 01:59:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=C8+ubTkFDb8J1f0gr5a+Bm4u1/nU6r2BzxnDBb9Es8o=;
 b=YvFQOzpx5ZkaiAzl7cssNZQnfgfYizL3yEwuoef1WEPT77NwdLjBPMckBQDw5nVAPY
 oFNxVSA6a3GtIk2jlAgeMVLpXDPZtqSaFw0y2E5Q3UD/0VsGKOwD9NQnOwoDP8mE5Cmt
 C8bm7a9cDi1KYxn6lGLY7UU7m8T9Lx83ONOavTldV78ApQidJOSuaVGESIZXt3VCsFSQ
 lgL3uleyw8jSeT7/fHREpwz2ZAM8Qq8QlM9GYEz8qDpSJflk5dkT+Wt/n9oc+5qEpngs
 19d/u9a6ol7HyiCDJVNLJla9XkW0gBnYwLtilh5rBHqzRv6fTGntKizqkhrHl5X6HjGy
 L1tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=C8+ubTkFDb8J1f0gr5a+Bm4u1/nU6r2BzxnDBb9Es8o=;
 b=XCx7EJXBYb+aRuqzvU1zLSm0/elmpX+nW1j0mJ/oUc2EVCmXiATYQYAXm9GygnOlW6
 q+hTYCntiiW5F5p9uH8QwXP2DSpExgNOYobiuc6MuB5YDfmXGgvof4ZCthpHRCVwcFFZ
 AsYx2nN6pv/OXnffad+De93bzpIUkrREmmLepMuURlP3by7La40BM7aH5Sn3RDK5SxS2
 3nDz2DhFIappwH+825qcI7VEACqmbjZrr134Vr225nsNIOP+rA20JkO0nim8BHloiwBk
 s9pg5lxnR4EDFqvZmLyvd7RfcRj60tMK3/XTqW3uu0sCi+4s5sG5L/XhQU2LSebHmGQx
 nwCA==
X-Gm-Message-State: AOAM533iumoKYX02xe1R2IsXStwmq4b75O9PDtTFKbTiXd2Ewnnx6yVV
 74XVTqnzhSry9Q+A33FrXgI=
X-Google-Smtp-Source: ABdhPJwYIrcDISA77EQrdq94p5wiJUoxP7QP+M8sPPtW82gkRe46hxODw9nt3B7PCuRYJ5ZRWhaLsQ==
X-Received: by 2002:a63:484d:: with SMTP id x13mr1944847pgk.301.1606903169459; 
 Wed, 02 Dec 2020 01:59:29 -0800 (PST)
Received: from localhost ([103.220.76.197])
 by smtp.gmail.com with ESMTPSA id e18sm1597708pgr.71.2020.12.02.01.59.27
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 02 Dec 2020 01:59:29 -0800 (PST)
Date: Wed, 2 Dec 2020 17:59:29 +0800
From: Yue Hu <zbestahu@gmail.com>
To: Gao Xiang <hsiangkao@redhat.com>
Subject: Re: About Segmentation fault of mkfs.erofs in AOSP
Message-ID: <20201202175929.0000666a.zbestahu@gmail.com>
In-Reply-To: <20201201115158.GA1325175@xiangao.remote.csb>
References: <20201201192309.00007531.zbestahu@gmail.com>
 <20201201114253.GA1323470@xiangao.remote.csb>
 <20201201194843.000068c5.zbestahu@gmail.com>
 <20201201115158.GA1325175@xiangao.remote.csb>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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
Cc: huyue2@yulong.com, linux-erofs <linux-erofs@lists.ozlabs.org>,
 zhangwen@yulong.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Tue, 1 Dec 2020 19:51:58 +0800
Gao Xiang <hsiangkao@redhat.com> wrote:

> On Tue, Dec 01, 2020 at 07:48:43PM +0800, Yue Hu wrote:
> > On Tue, 1 Dec 2020 19:42:53 +0800
> > Gao Xiang <hsiangkao@redhat.com> wrote:
> >   
> > > Hi Yue,
> > > 
> > > On Tue, Dec 01, 2020 at 07:23:09PM +0800, Yue Hu wrote:  
> > > > hi guys,
> > > > 
> > > > I'm trying using erofs for super.img(dynamic partition) under Android 10. But i have met an issue below when building images:
> > > > 
> > > > ```log
> > > > EROFS: write_uncompressed_block() Line[140] Writing 3517 uncompressed data to block 63950
> > > > EROFS: erofs_mkfs_build_tree() Line[1011] add file /tmp/merge_target_files_jnIVhM/output/VENDOR/etc/xtwifi.conf (nid 8185600, type 1)
> > > > EROFS: erofs_mkfs_build_tree() Line[1011] add file /tmp/merge_target_files_jnIVhM/output/VENDOR/etc (nid 1790208, type 2)
> > > > out/host/linux-x86/bin/mkerofsimage.sh: line 79: 188014 Segmentation fault      (core dumped) $MAKE_EROFS_CMD
> > > > ```
> > > > 
> > > > Have you met this kind of issue? I'm trying to debug the problem, looks like memory related.
> > > > 
> > > > BTW: i'm using latest erofs-utils in AOSP master branch (https://android.googlesource.com/platform/external/erofs-utils/).    
> > > 
> > > Which lz4 version is used? it would be better to use lz4 1.9.3
> > > (or 1.9.2 with some unexpected CR issues.)  
> > 
> > Hi Xiang,
> > 
> > ok, let me check.  
> 
> At least, lz4 1.8.3 ~ 1.9.1 are buggy, for more details, see:
> https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs-utils.git/tree/README?h=dev#n107
> 

wow, working fine when i upgrade lz4 version from 1.8.3 to 1.9.3 bypass vndk error.

And seems canned fs config processing has minor issue. I will double check and submit patch if possible.

Thank you!

> >   
> > > For more details, please see README.
> > > 
> > > If the expected lz4 version is used, could you kindly leave gdb
> > > backtrace message here as well?   
> > 
> > Trying to get the bt for the case.  
> 
> Yeah, bt will fall into lz4 internal functions if the lz4
> version is too low.
> 
> Thanks,
> Gao Xiang
> 
> > 
> > Thx.
> >   
> > > 
> > > Thanks,
> > > Gao Xiang
> > >   
> > > > 
> > > > Thx.
> > > >     
> > >   
> >   
> 

