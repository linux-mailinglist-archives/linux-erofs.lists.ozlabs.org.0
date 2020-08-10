Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 38D082405A8
	for <lists+linux-erofs@lfdr.de>; Mon, 10 Aug 2020 14:16:14 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BQFLM46txzDqT6
	for <lists+linux-erofs@lfdr.de>; Mon, 10 Aug 2020 22:16:11 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=207.211.31.120;
 helo=us-smtp-1.mimecast.com; envelope-from=hsiangkao@redhat.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=hrzdbe/s; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=hrzdbe/s; 
 dkim-atps=neutral
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [207.211.31.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BQFLD4vzKzDqJH
 for <linux-erofs@lists.ozlabs.org>; Mon, 10 Aug 2020 22:16:04 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597061761;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mFGq01KB6yv2eF3br0aTnbULoIv6iDtWfkD0dwkNAI0=;
 b=hrzdbe/suvHLV690hffor2q7rmmR8ibz7Cn+gLVzp2uZZOB0D5APTSRiQ1N0N5vd6XL2az
 AGnlr/vdXsmoaUq0/looD6mgAh2/NI26xVD6SbNeTNEqsldhp+nlbF3f0ijP3RkiBdRSbL
 /qllBjvgtlWprxfPvSsAHX9rTWsmjGY=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597061761;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mFGq01KB6yv2eF3br0aTnbULoIv6iDtWfkD0dwkNAI0=;
 b=hrzdbe/suvHLV690hffor2q7rmmR8ibz7Cn+gLVzp2uZZOB0D5APTSRiQ1N0N5vd6XL2az
 AGnlr/vdXsmoaUq0/looD6mgAh2/NI26xVD6SbNeTNEqsldhp+nlbF3f0ijP3RkiBdRSbL
 /qllBjvgtlWprxfPvSsAHX9rTWsmjGY=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-511-7n76jlKSP_GAHc9L5JxUDA-1; Mon, 10 Aug 2020 08:14:47 -0400
X-MC-Unique: 7n76jlKSP_GAHc9L5JxUDA-1
Received: by mail-pf1-f198.google.com with SMTP id y13so7632422pfp.5
 for <linux-erofs@lists.ozlabs.org>; Mon, 10 Aug 2020 05:14:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=mFGq01KB6yv2eF3br0aTnbULoIv6iDtWfkD0dwkNAI0=;
 b=Zb3SBMUSIJChpU7tISxqky3xsPvXrHVR+jg5rdOtONh4eXLGOPP+9X2tsrjoRCNknb
 UjB8w6f906Neh8R2J9Q5gmEb35vlGm3ALuIWzSCc5BSoP9JQ6bRvBatPYlcYV+Zhq4iL
 dfUvPcQzZbkWm2KA/73z9Lbh7LarYCRMFYdl7pqTraShZgX6aIShYA7yhtFEbS/KbK+x
 AAxSyoe1+iXb1myfeCEdT9wDqn3CSi3wtjby7kBPc0X+t3gWwysUQdUE6h+Lk22WhGtL
 L3p6YRN12U5swrijzfHZN9nzTopq2v467G1eRWQM8oudd4hTUZU+lBm4jh8Wwcxc34rE
 9ueQ==
X-Gm-Message-State: AOAM531cyMJvVI33zH05A+X1IYxQU/zaLK379U8mxUB6TlcOIZonBSZB
 4zeV58FTvKF3ru3RANMPNwzHfZDU8ezTdT0FoPoyHbqKrBBdHv6xl5pu7upjKrhnOqMgZV+vmZG
 eInytcGaKXMIan+uzKzG8FKcT
X-Received: by 2002:a17:90a:b78e:: with SMTP id
 m14mr25463848pjr.94.1597061686087; 
 Mon, 10 Aug 2020 05:14:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxwzStnT1u0RTwRtZhvrYJsV6+Z8bupkxANdv4pxTA87mAexwynwJf+TvDHVo5R1Izkxqwdlg==
X-Received: by 2002:a17:90a:b78e:: with SMTP id
 m14mr25463826pjr.94.1597061685829; 
 Mon, 10 Aug 2020 05:14:45 -0700 (PDT)
Received: from xiangao.remote.csb ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id a2sm23693831pfh.152.2020.08.10.05.14.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Aug 2020 05:14:45 -0700 (PDT)
Date: Mon, 10 Aug 2020 20:14:34 +0800
From: Gao Xiang <hsiangkao@redhat.com>
To: Chao Yu <yuchao0@huawei.com>, linmiaohe <linmiaohe@huawei.com>
Subject: Re: [PATCH] erofs: Convert to use the fallthrough macro
Message-ID: <20200810121434.GA13109@xiangao.remote.csb>
References: <1596878486-23499-1-git-send-email-linmiaohe@huawei.com>
 <f8ff563e-3d20-fc44-37ca-7eb05407ddc8@huawei.com>
MIME-Version: 1.0
In-Reply-To: <f8ff563e-3d20-fc44-37ca-7eb05407ddc8@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=hsiangkao@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
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
Cc: xiang@kernel.org, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Mon, Aug 10, 2020 at 11:39:42AM +0800, Chao Yu wrote:
> On 2020/8/8 17:21, linmiaohe wrote:
> > From: Miaohe Lin <linmiaohe@huawei.com>
> > 
> > Convert the uses of fallthrough comments to fallthrough macro.
> > 
> > Signed-off-by: Hongxiang Lou <louhongxiang@huawei.com>
> > Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> 
> Reviewed-by: Chao Yu <yuchao0@huawei.com>

Looks good to me too,

Reviewed-by: Gao Xiang <hsiangkao@redhat.com>

(Although it seems some exist discussions here, e.g.,
 https://lore.kernel.org/r/20200708065512.GN2005@dread.disaster.area 
 Will confirm that before the next cycle.)

Thanks,
Gao Xiang

> 
> Thanks,
> 

