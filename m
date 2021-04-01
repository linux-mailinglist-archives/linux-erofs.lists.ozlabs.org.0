Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 56E51350EAE
	for <lists+linux-erofs@lfdr.de>; Thu,  1 Apr 2021 08:02:00 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4F9syT2v47z3049
	for <lists+linux-erofs@lfdr.de>; Thu,  1 Apr 2021 17:01:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QZSEF3ts;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=c+FiaeYa;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=216.205.24.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=hsiangkao@redhat.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=QZSEF3ts; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=c+FiaeYa; 
 dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4F9syR3pNqz2yRy
 for <linux-erofs@lists.ozlabs.org>; Thu,  1 Apr 2021 17:01:49 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1617256904;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uRp0FnEdaqle2H/TogerMFKhoHHBVp1EhFPgzJWw6ac=;
 b=QZSEF3tsnEqz6E7PjKnRP+S3lVUH6AZ9+lHJJh1KTVL66h8krRt62kBptpOM3+bJOQCOa5
 J8DhDxuXqV63yVP5lYs7M6Q9Si3jySVvZAp0/uJLpwxf1TbaO39MkKqcEvOLgStguooqSr
 ao7BWH+0fEjvo2pAgpQ7mGjIiuUuvBI=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1617256905;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uRp0FnEdaqle2H/TogerMFKhoHHBVp1EhFPgzJWw6ac=;
 b=c+FiaeYazykxYHBf5afMWtfaO5p/qjrdYAyPm/emgTwN0plPhGjpcOIaJ2UWbxBX9gMlMe
 sEtS7ihgg0TbI8kOJDOD4G7IVMU6C5TnP20zVN8btDrq+9CS2kCwqxaT7sZfjxxtdPNtcu
 nB9Qy0gry+zuBI2UMbVkzzRkMbCrGVY=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-567-OcxNtm-ZO9mEzky12beIKQ-1; Thu, 01 Apr 2021 02:01:43 -0400
X-MC-Unique: OcxNtm-ZO9mEzky12beIKQ-1
Received: by mail-pj1-f70.google.com with SMTP id r18so2609877pjz.1
 for <linux-erofs@lists.ozlabs.org>; Wed, 31 Mar 2021 23:01:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=uRp0FnEdaqle2H/TogerMFKhoHHBVp1EhFPgzJWw6ac=;
 b=oeXAc6oLI+bv+3H1tkP/D8nFuWOJQ+nt0W/8eTP5jHLW8vkTapyf/xbRBKOuNxMSeO
 5Vho3aZd63Qo5TPksu7cPvrenGP9wVv9muJtI+rhY8rlpW1GcgeT06p90nLQTab4qy9s
 Jj70wSpVObWguuT+H679La1bw7aeEitECQATvzbjeLXaVzUA0aBMDf2X2EGHxHJD9JxM
 9HHt3IlQxdEcBHpwJ5uNFcrl+5zK/MAzBasf/pgJWINIo/XsLlkxon8ZX9FZEAJKxem/
 7HO2xSQ6OgipLs9M1PjOSGPlIt7m59plhy5e2wwSfIuq26ka6WX13wrIH8yI0FICLYAu
 VBFw==
X-Gm-Message-State: AOAM533xK86YpWYvKd1nr07vGTTpNB/wEixUGYJP0lrIvH10pksQ5jQt
 KJBlf9a5wwiPdCVQ1387oPu2BdQN8EuV9aNl6+yvunyE5jHEuEam0EAI8aO54RuGOxrb6au79Yv
 ZEFsWO1Eu8qsR0dsAmq+xarmh
X-Received: by 2002:a63:2259:: with SMTP id t25mr6082462pgm.395.1617256901999; 
 Wed, 31 Mar 2021 23:01:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxnZAPRGA9OBW9PMkBZS4dz2pRpf7kQylYUYycKMmq14JgVkE39uxi8OK0GM2lWo0k9NUiwFw==
X-Received: by 2002:a63:2259:: with SMTP id t25mr6082451pgm.395.1617256901754; 
 Wed, 31 Mar 2021 23:01:41 -0700 (PDT)
Received: from xiangao.remote.csb ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id gm9sm4010629pjb.13.2021.03.31.23.01.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Mar 2021 23:01:41 -0700 (PDT)
Date: Thu, 1 Apr 2021 14:01:32 +0800
From: Gao Xiang <hsiangkao@redhat.com>
To: Hu Weiwen <sehuww@mail.scut.edu.cn>
Subject: Re: [PATCH] erofs-utils: add command line argument to override uid/gid
Message-ID: <20210401060132.GA3827683@xiangao.remote.csb>
References: <20210401052903.18700-1-sehuww@mail.scut.edu.cn>
MIME-Version: 1.0
In-Reply-To: <20210401052903.18700-1-sehuww@mail.scut.edu.cn>
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

On Thu, Apr 01, 2021 at 01:29:03PM +0800, Hu Weiwen wrote:
> Also added '--all-root' option to set uid and gid to root conveniently.
> 
> This function can be useful if we want to pack some data owned by user with
> large uid, but we want to use compact inode.
> 
> Signed-off-by: Hu Weiwen <sehuww@mail.scut.edu.cn>

How about using long options for all options, e.g.
 --all-root,
 --force-uid=,
 --force-gid=, (seems squashfs uses such naming).

since I'd like to leave short options for more common usages.

And you might need to update manpage as well, so I can apply it
ASAP...

(Btw, even compact inodes have 16-bit ranges, we could introduce
 some mapping table to remap sparse uid/gid into a compact form,
 if that is what you want, you could help to implement it as well :) )

Thanks,
Gao Xiang

