Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 28DEE1F9110
	for <lists+linux-erofs@lfdr.de>; Mon, 15 Jun 2020 10:09:30 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49lkWW329dzDqLx
	for <lists+linux-erofs@lfdr.de>; Mon, 15 Jun 2020 18:09:27 +1000 (AEST)
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
 header.s=mimecast20190719 header.b=MQeAtAU6; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=FgpHdlYC; 
 dkim-atps=neutral
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [207.211.31.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49lkTM3CJczDqLx
 for <linux-erofs@lists.ozlabs.org>; Mon, 15 Jun 2020 18:07:34 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592208450;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BeGGnxeP+9Ph9j16Zyt+G5pj4OrBDsCw7yZLIS0o8yM=;
 b=MQeAtAU65k3uLytcQc7kanJwXCYaRtK3QsGz7IzBwIDJSZWL4oyr/qUlgCsoRJkoINq3O7
 Talg104SV74B1RF+II1dFGNuK4KhHe+eEN4sp/PN68FOu+l+iuC2PbDV3yAGZDUBX4o8Sj
 zzHKYvub6tSIq/VhmqUujdWYBPd8CFM=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592208451;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BeGGnxeP+9Ph9j16Zyt+G5pj4OrBDsCw7yZLIS0o8yM=;
 b=FgpHdlYC/gCuPfSEiuPPQmn1HQ5V7sVxdyAUxe9kryGtQ/kC0w5tU96Ws2QjriptkkIffR
 PEwUe7QxINT65NEXlAKJjLIr+kLHa0DMROVdt/VgszxXxT3Esu0kQEPrEC9Xdrkdx7QAzm
 doCjOTA6UdlZm9kw2RY8LgLAeISKy6s=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-491-3GGZJS3sNgWahNq40KMVAA-1; Mon, 15 Jun 2020 04:07:27 -0400
X-MC-Unique: 3GGZJS3sNgWahNq40KMVAA-1
Received: by mail-pl1-f199.google.com with SMTP id bh7so10825345plb.2
 for <linux-erofs@lists.ozlabs.org>; Mon, 15 Jun 2020 01:07:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=+QGlrYD7CnoOZ2xHryUMQtseNDSspP2GFuEENx6xWTg=;
 b=PomN8jBC7ZUQd1LwICsH69Airphm6bNwtE94ejViBp8L0A2evw5hF3vAWO18mejzFA
 sbRt6/Csjn06HFPVHxMHXaS1Z0EAfyl/VrsiMK2WSM0/HWJfWNZXX9+DYZv5yefCa48I
 tqxvTCJc28s2aumQdcEg46DPO2QkcjY9mxbSubU1NRuvwcmlXwskhlNxkv4Td18XXk8n
 mAzHYWTmf/nWOwm8Dmv2FylPTu2/qMNmdGD28ltnuv7Hx4YYm+ST8JgBYBsqruD/d7wI
 jsgrQ7gs0zHgdgf5x7VD/Q9BY2mz0+0xJnU8YZDb1fv/sew0BZ32blX/gD+QcNodIAFl
 CuFw==
X-Gm-Message-State: AOAM531heWzRgYbJoJXteFgy+vpkFgr/Z/ilqV9Oy3EMN9xtAj3XN6VN
 zoXOTeAKcmpE8NFWSqqHKsdyAQikYl6bXADh/ZBVN2NCFB04nv3/PFtpKcj11toD/W3jiPTErhr
 f1qI0pPiyVSUqyY6dFgB+Ov+N
X-Received: by 2002:a17:90a:ad03:: with SMTP id
 r3mr11041329pjq.104.1592208446519; 
 Mon, 15 Jun 2020 01:07:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzzQIhf04M46QfAh9dC0OF2x3Gg0pBCHU0ZNkauVlVtPuKKppWZqX7qMQYC9uA7dNku9F6pOQ==
X-Received: by 2002:a17:90a:ad03:: with SMTP id
 r3mr11041302pjq.104.1592208446284; 
 Mon, 15 Jun 2020 01:07:26 -0700 (PDT)
Received: from xiangao.remote.csb ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id o2sm11603522pjp.53.2020.06.15.01.07.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2020 01:07:25 -0700 (PDT)
Date: Mon, 15 Jun 2020 16:07:14 +0800
From: Gao Xiang <hsiangkao@redhat.com>
To: Jason Yan <yanaijie@huawei.com>
Subject: Re: [PATCH] erofs: Eliminate usage of uninitialized_var() macro
Message-ID: <20200615080714.GB25317@xiangao.remote.csb>
References: <20200615040141.3627746-1-yanaijie@huawei.com>
 <20200615072521.GA25317@xiangao.remote.csb>
 <783fe4f9-fb1f-7f5e-c900-7e30d5c85222@huawei.com>
MIME-Version: 1.0
In-Reply-To: <783fe4f9-fb1f-7f5e-c900-7e30d5c85222@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 8bit
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
Cc: Kees Cook <keescook@chromium.org>, kernel-hardening@lists.openwall.com,
 gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, xiang@kernel.org,
 linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Mon, Jun 15, 2020 at 03:43:09PM +0800, Jason Yan wrote:
> 
> 
> 在 2020/6/15 15:25, Gao Xiang 写道:
> > Hi Jason,
> > 
> > On Mon, Jun 15, 2020 at 12:01:41PM +0800, Jason Yan wrote:
> > > This is an effort to eliminate the uninitialized_var() macro[1].
> > > 
> > > The use of this macro is the wrong solution because it forces off ANY
> > > analysis by the compiler for a given variable. It even masks "unused
> > > variable" warnings.
> > > 
> > > Quoted from Linus[2]:
> > > 
> > > "It's a horrible thing to use, in that it adds extra cruft to the
> > > source code, and then shuts up a compiler warning (even the _reliable_
> > > warnings from gcc)."
> > > 
> > > The gcc option "-Wmaybe-uninitialized" has been disabled and this change
> > > will not produce any warnnings even with "make W=1".
> > > 
> > > [1] https://github.com/KSPP/linux/issues/81
> > > [2] https://lore.kernel.org/lkml/CA+55aFz2500WfbKXAx8s67wrm9=yVJu65TpLgN_ybYNv0VEOKA@mail.gmail.com/
> > > 
> > > Cc: Kees Cook <keescook@chromium.org>
> > > Cc: Chao Yu <yuchao0@huawei.com>
> > > Signed-off-by: Jason Yan <yanaijie@huawei.com>
> > > ---
> > 
> > I'm fine with the patch since "-Wmaybe-uninitialized" has been disabled and
> > I've also asked Kees for it in private previously.
> > 
> > I still remembered that Kees sent out a treewide patch. Sorry about that
> > I don't catch up it... But what is wrong with the original patchset?
> > 
> 
> Yes, Kees has remind me of that and I will let him handle it. So you can
> ignore this patch.

Okay, I was just wondering if this part should be send out via EROFS tree
for this cycle. However if there was an automatic generated patch by Kees,
I think perhaps Linus could pick them out directly. But anyway, both ways
are fine with me. ;) Ping me when needed.

Thanks,
Gao Xiang

> 
> Thanks,
> Jason
> 
> > Thanks,
> > Gao Xiang
> > 
> > 
> > .
> > 
> 

