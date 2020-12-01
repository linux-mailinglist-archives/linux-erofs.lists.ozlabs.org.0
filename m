Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F35DC2CA1B1
	for <lists+linux-erofs@lfdr.de>; Tue,  1 Dec 2020 12:43:48 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ClgGk50T5zDqjT
	for <lists+linux-erofs@lfdr.de>; Tue,  1 Dec 2020 22:43:42 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=216.205.24.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=hsiangkao@redhat.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=CNzc2QxH; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=CNzc2QxH; 
 dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4ClgGB1kmKzDqhm
 for <linux-erofs@lists.ozlabs.org>; Tue,  1 Dec 2020 22:43:12 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1606822988;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3epPrWyymxCw5QpnB1G3ZHimwO29d3kIyILHRmrFqMA=;
 b=CNzc2QxHTUtCX/WaR5BxKrnlNe/mcVet+iJNK/axOAcEwzMXAg9huauuc2oiiohPl4aiut
 HXq7sV0NIfrxRTSMNXRc+0fv+CbQmE7C0a7wZS8bDDk/PhKjRW4KckdaSIpowRC3A7qvPR
 V0GhfREXPHwVnAWm5Xf9BMxD3oeZK10=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1606822988;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3epPrWyymxCw5QpnB1G3ZHimwO29d3kIyILHRmrFqMA=;
 b=CNzc2QxHTUtCX/WaR5BxKrnlNe/mcVet+iJNK/axOAcEwzMXAg9huauuc2oiiohPl4aiut
 HXq7sV0NIfrxRTSMNXRc+0fv+CbQmE7C0a7wZS8bDDk/PhKjRW4KckdaSIpowRC3A7qvPR
 V0GhfREXPHwVnAWm5Xf9BMxD3oeZK10=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-587-TSXkfB3JN8uUcRc1bsUg3Q-1; Tue, 01 Dec 2020 06:43:05 -0500
X-MC-Unique: TSXkfB3JN8uUcRc1bsUg3Q-1
Received: by mail-pl1-f198.google.com with SMTP id t13so1035313plo.16
 for <linux-erofs@lists.ozlabs.org>; Tue, 01 Dec 2020 03:43:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=3epPrWyymxCw5QpnB1G3ZHimwO29d3kIyILHRmrFqMA=;
 b=lzFuxoKdOtdwHjhBEfza/44Zu0gryT8VSkXdRlWUPUaUPcSp1YXuJ4Lg6NjSAPi71m
 LF88bn7xXcgUrVKpynBK9SEvQa4HZ3jK7hnEfPZZCZBLm4fbQlGmRiEiPP7S3ogPUJs5
 KEsJMJgBOfZJMWjyWqqjk29VKigeLeHZOMASPi37joS56/m1r/hqjDcdWFCH79E5xm8Q
 7XqLod/hVfVlixQ/gkvm0apyuCS6L/WKTXUK9KhINHZbGkfMyGRzrtLFdajU6owzLqtD
 LkUPMaOxRWRI4J8KzY6LaoEkOZhaXrz2GIhvkyhXtswaPe1T4DEbvbgO9p3QawYEBbk1
 jQ+Q==
X-Gm-Message-State: AOAM532Ns0+Kq+X4V5ucgl4PfPYpGUb8cUaxFPmjPV/dvY0jamrrqRo/
 QpJyolHU4cvIuoq2z/VnmLthBMdKc5wFH6XoQUBSkXENz1ea0BTt8LdvJghhOvDNVIL4pxtpuOb
 /h86e9G7fTRBxNT6BUzXVKqec
X-Received: by 2002:a62:52d7:0:b029:18b:7093:fb88 with SMTP id
 g206-20020a6252d70000b029018b7093fb88mr2128585pfb.76.1606822984711; 
 Tue, 01 Dec 2020 03:43:04 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxn1AAt5URaQHkhKt5zOuaGFMcamyOAFZgBg0SmrTAoUgklS+Q/zX/Aazvdq8/ebOyJqewwaw==
X-Received: by 2002:a62:52d7:0:b029:18b:7093:fb88 with SMTP id
 g206-20020a6252d70000b029018b7093fb88mr2128575pfb.76.1606822984467; 
 Tue, 01 Dec 2020 03:43:04 -0800 (PST)
Received: from xiangao.remote.csb ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id x21sm2429011pfc.151.2020.12.01.03.43.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Dec 2020 03:43:03 -0800 (PST)
Date: Tue, 1 Dec 2020 19:42:53 +0800
From: Gao Xiang <hsiangkao@redhat.com>
To: Yue Hu <zbestahu@gmail.com>
Subject: Re: About Segmentation fault of mkfs.erofs in AOSP
Message-ID: <20201201114253.GA1323470@xiangao.remote.csb>
References: <20201201192309.00007531.zbestahu@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20201201192309.00007531.zbestahu@gmail.com>
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

Hi Yue,

On Tue, Dec 01, 2020 at 07:23:09PM +0800, Yue Hu wrote:
> hi guys,
> 
> I'm trying using erofs for super.img(dynamic partition) under Android 10. But i have met an issue below when building images:
> 
> ```log
> EROFS: write_uncompressed_block() Line[140] Writing 3517 uncompressed data to block 63950
> EROFS: erofs_mkfs_build_tree() Line[1011] add file /tmp/merge_target_files_jnIVhM/output/VENDOR/etc/xtwifi.conf (nid 8185600, type 1)
> EROFS: erofs_mkfs_build_tree() Line[1011] add file /tmp/merge_target_files_jnIVhM/output/VENDOR/etc (nid 1790208, type 2)
> out/host/linux-x86/bin/mkerofsimage.sh: line 79: 188014 Segmentation fault      (core dumped) $MAKE_EROFS_CMD
> ```
> 
> Have you met this kind of issue? I'm trying to debug the problem, looks like memory related.
> 
> BTW: i'm using latest erofs-utils in AOSP master branch (https://android.googlesource.com/platform/external/erofs-utils/).

Which lz4 version is used? it would be better to use lz4 1.9.3
(or 1.9.2 with some unexpected CR issues.)
For more details, please see README.

If the expected lz4 version is used, could you kindly leave gdb
backtrace message here as well? 

Thanks,
Gao Xiang

> 
> Thx.
> 

