Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4889B2CA1C9
	for <lists+linux-erofs@lfdr.de>; Tue,  1 Dec 2020 12:52:39 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ClgSz673nzDqk9
	for <lists+linux-erofs@lfdr.de>; Tue,  1 Dec 2020 22:52:35 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=63.128.21.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=hsiangkao@redhat.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=bbHrTNt4; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=bbHrTNt4; 
 dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4ClgSb2h45zDqNg
 for <linux-erofs@lists.ozlabs.org>; Tue,  1 Dec 2020 22:52:15 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1606823532;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WKZ/LG/LqaHKVs7p5qS5GBGXdiIhV8SxujXqt7MtRIc=;
 b=bbHrTNt4rlQ0yMeufLYCZ+Y0IQJ3JFXtyMM3FR3Fc6dck414S0kllCB3NDt0Io+vJnRjbq
 YWnnEk+TjX7npHB13aPie9em0P7uSjtsiOHYGlqk8ZVcJvAgGG0ZR36Vng1CHaIvlDV5ON
 PLGib05VMo9pDZIPMw4oCPDJBcFnDio=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1606823532;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WKZ/LG/LqaHKVs7p5qS5GBGXdiIhV8SxujXqt7MtRIc=;
 b=bbHrTNt4rlQ0yMeufLYCZ+Y0IQJ3JFXtyMM3FR3Fc6dck414S0kllCB3NDt0Io+vJnRjbq
 YWnnEk+TjX7npHB13aPie9em0P7uSjtsiOHYGlqk8ZVcJvAgGG0ZR36Vng1CHaIvlDV5ON
 PLGib05VMo9pDZIPMw4oCPDJBcFnDio=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-102-bpK5iJT7ONWEcbhYNzj3sg-1; Tue, 01 Dec 2020 06:52:10 -0500
X-MC-Unique: bpK5iJT7ONWEcbhYNzj3sg-1
Received: by mail-pj1-f70.google.com with SMTP id u2so913525pje.0
 for <linux-erofs@lists.ozlabs.org>; Tue, 01 Dec 2020 03:52:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=WKZ/LG/LqaHKVs7p5qS5GBGXdiIhV8SxujXqt7MtRIc=;
 b=Ccq9nwKODc0qc3/ztXSjZfL4cnelE/I6rnNgWnsyT9AvjbY0xor9aZ0/W5zH+PthMZ
 /izd8ZWxtbn8OPgx7wrYtW+WSwQV7BI5UHohlrz2PJwjXlAk9xUE6Lmdf230AbiGagxi
 K5rKRXtx8w790z2NRzQ9YV0eSSQCpXf+jC0kgUxlgaAh23LAnCHJtzTa513KaeQAniN0
 pXF3ODLS2grgUnza71rx0knmgGs5p4C9dz+f92iIHOOp58GozIpFXxD3zd1pVPZ0HQNd
 /GfBWu6BlLE5EnvEDjVcCdTDdbOWVpOh7HW/Du/fgtQUSsg7qFJYgVMvseN8w2LzlP99
 S93g==
X-Gm-Message-State: AOAM533LjA+yg3ymrHpcNpSfqyWOmg7Y98HfJBM+PRW++v2m58YaQ+hL
 ywoEDDIfc605T6yPnkA2cOvuqi25ECfuZoY66kmlFPpn4q9Y24Az+YtnrBVKdNAJVRx+V0OsDfy
 M5V/5Z9O7c+AfjMAq9i1cgKPC
X-Received: by 2002:aa7:8a90:0:b029:19b:1166:2a22 with SMTP id
 a16-20020aa78a900000b029019b11662a22mr2054889pfc.31.1606823529341; 
 Tue, 01 Dec 2020 03:52:09 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxrvPFChfxnLTfcuPB1N1OSYvqip3XYlNIxlKN2cqgPPJWFycmUR36yaQHRynP+J5scBJM77A==
X-Received: by 2002:aa7:8a90:0:b029:19b:1166:2a22 with SMTP id
 a16-20020aa78a900000b029019b11662a22mr2054872pfc.31.1606823529095; 
 Tue, 01 Dec 2020 03:52:09 -0800 (PST)
Received: from xiangao.remote.csb ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id z12sm2635146pfg.123.2020.12.01.03.52.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Dec 2020 03:52:08 -0800 (PST)
Date: Tue, 1 Dec 2020 19:51:58 +0800
From: Gao Xiang <hsiangkao@redhat.com>
To: Yue Hu <zbestahu@gmail.com>
Subject: Re: About Segmentation fault of mkfs.erofs in AOSP
Message-ID: <20201201115158.GA1325175@xiangao.remote.csb>
References: <20201201192309.00007531.zbestahu@gmail.com>
 <20201201114253.GA1323470@xiangao.remote.csb>
 <20201201194843.000068c5.zbestahu@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20201201194843.000068c5.zbestahu@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=hsiangkao@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
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
Cc: huyue2@yulong.com, linux-erofs <linux-erofs@lists.ozlabs.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Tue, Dec 01, 2020 at 07:48:43PM +0800, Yue Hu wrote:
> On Tue, 1 Dec 2020 19:42:53 +0800
> Gao Xiang <hsiangkao@redhat.com> wrote:
> 
> > Hi Yue,
> > 
> > On Tue, Dec 01, 2020 at 07:23:09PM +0800, Yue Hu wrote:
> > > hi guys,
> > > 
> > > I'm trying using erofs for super.img(dynamic partition) under Android 10. But i have met an issue below when building images:
> > > 
> > > ```log
> > > EROFS: write_uncompressed_block() Line[140] Writing 3517 uncompressed data to block 63950
> > > EROFS: erofs_mkfs_build_tree() Line[1011] add file /tmp/merge_target_files_jnIVhM/output/VENDOR/etc/xtwifi.conf (nid 8185600, type 1)
> > > EROFS: erofs_mkfs_build_tree() Line[1011] add file /tmp/merge_target_files_jnIVhM/output/VENDOR/etc (nid 1790208, type 2)
> > > out/host/linux-x86/bin/mkerofsimage.sh: line 79: 188014 Segmentation fault      (core dumped) $MAKE_EROFS_CMD
> > > ```
> > > 
> > > Have you met this kind of issue? I'm trying to debug the problem, looks like memory related.
> > > 
> > > BTW: i'm using latest erofs-utils in AOSP master branch (https://android.googlesource.com/platform/external/erofs-utils/).  
> > 
> > Which lz4 version is used? it would be better to use lz4 1.9.3
> > (or 1.9.2 with some unexpected CR issues.)
> 
> Hi Xiang,
> 
> ok, let me check.

At least, lz4 1.8.3 ~ 1.9.1 are buggy, for more details, see:
https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs-utils.git/tree/README?h=dev#n107

> 
> > For more details, please see README.
> > 
> > If the expected lz4 version is used, could you kindly leave gdb
> > backtrace message here as well? 
> 
> Trying to get the bt for the case.

Yeah, bt will fall into lz4 internal functions if the lz4
version is too low.

Thanks,
Gao Xiang

> 
> Thx.
> 
> > 
> > Thanks,
> > Gao Xiang
> > 
> > > 
> > > Thx.
> > >   
> > 
> 

