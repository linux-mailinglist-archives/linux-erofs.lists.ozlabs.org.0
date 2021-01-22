Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2614E2FFA61
	for <lists+linux-erofs@lfdr.de>; Fri, 22 Jan 2021 03:32:23 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DMNZW5D1vzDrZD
	for <lists+linux-erofs@lfdr.de>; Fri, 22 Jan 2021 13:32:19 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=63.128.21.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=hsiangkao@redhat.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=CHmA1ryW; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=CHmA1ryW; 
 dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DMNZS0XkCzDrTf
 for <linux-erofs@lists.ozlabs.org>; Fri, 22 Jan 2021 13:32:15 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1611282731;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=P7rWxr5llL78YEZM6S8QzoKIXdUc09rvD7w9i7hbUco=;
 b=CHmA1ryWQX9xexv8PQ+iu7GyGFnNVhnya0wJsB2JjOKuyg2J5wZECyKA4PTqorAhXyNgRH
 2rVE7bpZo6PLa4iGjKKHmhS5cujPgYC4HVPE3wuE+13185r4q7Yz3rMEin+gq90sV+4CLk
 J2Exk5J3qqICnu0q9FZS6SnMM4eiMo4=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1611282731;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=P7rWxr5llL78YEZM6S8QzoKIXdUc09rvD7w9i7hbUco=;
 b=CHmA1ryWQX9xexv8PQ+iu7GyGFnNVhnya0wJsB2JjOKuyg2J5wZECyKA4PTqorAhXyNgRH
 2rVE7bpZo6PLa4iGjKKHmhS5cujPgYC4HVPE3wuE+13185r4q7Yz3rMEin+gq90sV+4CLk
 J2Exk5J3qqICnu0q9FZS6SnMM4eiMo4=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-100-La6xV0PDPc-95tIt3jdBiw-1; Thu, 21 Jan 2021 21:32:09 -0500
X-MC-Unique: La6xV0PDPc-95tIt3jdBiw-1
Received: by mail-pj1-f72.google.com with SMTP id o3so2978359pju.6
 for <linux-erofs@lists.ozlabs.org>; Thu, 21 Jan 2021 18:32:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=P7rWxr5llL78YEZM6S8QzoKIXdUc09rvD7w9i7hbUco=;
 b=o1JANtFg3Icx9UuXzQ4DGH5ONVkKO68H0lr34G+lE8qLvUy81rtUPYjr9+MLwzjOsw
 75dBSCQnI9OXEyiL8g6Qk3hEdw78NSfXNvnySjjGw16a/GXeKt2v8HvqV3CtmSc6pDTf
 gqUXwqbvDb5Q+1KqH5vI9wBOAVc7k77cWl4YpXiNgVoognDJ/toLX3Bd4+rZ9EmH8Z5P
 t6OkfaoAfFfthRxjcfhxPOc4tbLeNmgGe+oXrahKNSpFlPof+gCKmfmc/OHEYBcTwnuS
 mVk137rVBxMMatOjSUS4kZ230J10PA5SWzOKapJpbuZdLRXIwzmU/C8MbX/fjUIJM9KK
 T4dw==
X-Gm-Message-State: AOAM530issP3tYf3uTGV8K5YpXBpp9KbiFUmz9mKRC3nemMbsczMsx6m
 TT1bIijz5PqNlNrl8llzKiHa4rmZaqxbBMvUapdGp4iRvkK9QgftkEtAvusLFPwJe16Kr4vwTaW
 F6v4ieVE7jnGJkwONpg47Qsnw
X-Received: by 2002:a17:90a:4803:: with SMTP id
 a3mr2835171pjh.122.1611282728112; 
 Thu, 21 Jan 2021 18:32:08 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxIZ2hWIszOmAGrUqNAXh3u1WA1OlEHv7lsvSbPx1d6Thplr/ekzTznwLWzk3klJ5Myeh1K9g==
X-Received: by 2002:a17:90a:4803:: with SMTP id
 a3mr2835155pjh.122.1611282727795; 
 Thu, 21 Jan 2021 18:32:07 -0800 (PST)
Received: from xiangao.remote.csb ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id y10sm6816172pff.197.2021.01.21.18.32.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Jan 2021 18:32:07 -0800 (PST)
Date: Fri, 22 Jan 2021 10:31:57 +0800
From: Gao Xiang <hsiangkao@redhat.com>
To: Hu Weiwen <sehuww@mail.scut.edu.cn>
Subject: Re: [PATCH v2] erofs-utils: fix battach on full buffer block
Message-ID: <20210122023157.GG2996701@xiangao.remote.csb>
References: <20210120051216.GA2688693@xiangao.remote.csb>
 <20210121162606.8168-1-sehuww@mail.scut.edu.cn>
MIME-Version: 1.0
In-Reply-To: <20210121162606.8168-1-sehuww@mail.scut.edu.cn>
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
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Weiwen,

On Fri, Jan 22, 2021 at 12:26:06AM +0800, Hu Weiwen wrote:
> When __erofs_battach() is called on an buffer block of which
> (bb->buffers.off % EROFS_BLKSIZ == 0), `tail_blkaddr' will not be
> updated correctly. This bug can be reproduced by:
> 
> mkdir bug-repo
> head -c 4032 /dev/urandom > bug-repo/1
> head -c 4095 /dev/urandom > bug-repo/2
> head -c 12345 /dev/urandom > bug-repo/3  # arbitrary size
> mkfs.erofs -Eforce-inode-compact bug-repo.erofs.img bug-repo
> 
> Then mount this image and see that file `3' in the image is different
> from `bug-repo/3'.
> 
> This patch fix this by:
> 
> * Don't inline tail-end data in this case, since the tail-end data will
> be in a different block from inode.
> * Correctly handle `battach' in this case.
> 
> Signed-off-by: Hu Weiwen <sehuww@mail.scut.edu.cn>
> ---
> Hi Xiang,
> 
> I still think send this as a seperate patch would be better. In previous v6
> patch, I have fixed the erofs_mapbh() behaviour so that there should be no
> user-visible bug introduced in that patch. And this patch is almost unrelated
> to that optimization.
> 
> Compared with v1, this version fixes an error when compression is enabled.

I cannot tell too much of it for now (since it's not an obvious update,
I need to investagate). I will leave it this weekend.

Thanks,
Gao Xiang

> 
> Thanks,
> Hu Weiwen

