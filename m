Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB3041F0AB4
	for <lists+linux-erofs@lfdr.de>; Sun,  7 Jun 2020 11:52:02 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49fs9W3MQnzDqcD
	for <lists+linux-erofs@lfdr.de>; Sun,  7 Jun 2020 19:51:59 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=207.211.31.81;
 helo=us-smtp-delivery-1.mimecast.com; envelope-from=hsiangkao@redhat.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=ZJO5GSSl; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=GmevJpSm; 
 dkim-atps=neutral
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-1.mimecast.com
 [207.211.31.81])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49fs9L58gmzDqVK
 for <linux-erofs@lists.ozlabs.org>; Sun,  7 Jun 2020 19:51:47 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591523502;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=m2eVJtc6FiDb4Y2APAO8PsaIymgN9cXqpsvQGvBJCek=;
 b=ZJO5GSSlp2dF+IhoN0BfjYi+w7HqB4WEgI/dfT2zPc1AHsGlFkOx2aTWTe34CtMkl+xJ2H
 to80p3rbeegjIVjZy/0JzFj+pjax1o0tJHCrPDZYZYNG18S9oIeJGaW2iwCCFxbB7/w9K7
 Wkxb+Fynkh0Vpy1L4QGgN7mYg0DhcOo=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591523503;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=m2eVJtc6FiDb4Y2APAO8PsaIymgN9cXqpsvQGvBJCek=;
 b=GmevJpSmIiIFYpS12BWUfBxZQnFEwEJk4glRS4sAAu7vkMSBRCl8eVLE21ghq28c+iJqrX
 g2DyG4lGCvM9pc3p2emgZm1ObTR+JbP1lQD2KRIEtMU/pNWW3Sn0iFuQbo2kXgcK0LxhSC
 iMmrXhskWzv53uU+TnlOtPSupCZ2KkY=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-161--wfHf2CCMxi_G-xHZzbyhw-1; Sun, 07 Jun 2020 05:51:40 -0400
X-MC-Unique: -wfHf2CCMxi_G-xHZzbyhw-1
Received: by mail-pf1-f200.google.com with SMTP id c7so11137615pfi.21
 for <linux-erofs@lists.ozlabs.org>; Sun, 07 Jun 2020 02:51:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=m2eVJtc6FiDb4Y2APAO8PsaIymgN9cXqpsvQGvBJCek=;
 b=W9QAu987lLEMxYBhwZFKlll8GoOTfpgAw4OBd/JW+078Lodoiim4gLCPVaGxNZ9/GO
 rq8qiYZpNKAFxkU15j0Z8gWNHyomSsUbP44v04A3Bd25fAl3v9yg0WgSbQbuW0RoPTpj
 evzDFz6myYL6F6nizmwKteRwFaNFAjTBUyPO1bONc/jS6JaD0LTqWMLO0J/+u5QoD9CY
 HePuviMUTB7e7snOaCTreDrBF+f9cWX8VCc+MsWNyIcUnCWnJGD2EYm7NDrtAq+/LpdX
 IrE9HwhuiHbg4oyzlnAh1BgJYfH1rKxtFDhN0j80PQNtqqLLP7a9+vwT+JUWH4GBgSW6
 wDow==
X-Gm-Message-State: AOAM532X/BvQ5OjaVrTKH0faGSFRUfOLsdlP1aFI0zMS68pycSr4RpzU
 lpBn+IYwS8+PWngnzq5i4piWX74cXU3xX00wIDZpjbwA8qQCCnTszHYTOQcOMb5T1HXyerA935H
 tU1WaSpHj1oV3ICUIzTl0kFVp
X-Received: by 2002:a62:168d:: with SMTP id 135mr16112649pfw.239.1591523499781; 
 Sun, 07 Jun 2020 02:51:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxJ51bRvMSVuTj5xUH0hv96lUAg617VW9C+6taZKq2ywmmWqsUZ8SZ8zHhjFqz9qVjyDTRa9w==
X-Received: by 2002:a62:168d:: with SMTP id 135mr16112637pfw.239.1591523499462; 
 Sun, 07 Jun 2020 02:51:39 -0700 (PDT)
Received: from xiangao.remote.csb ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id x14sm4106926pfq.80.2020.06.07.02.51.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 07 Jun 2020 02:51:38 -0700 (PDT)
Date: Sun, 7 Jun 2020 17:51:28 +0800
From: Gao Xiang <hsiangkao@redhat.com>
To: Li GuiFu <bluce.lee@aliyun.com>
Subject: Re: [PATCH v2] erofs-utils: support selinux file contexts
Message-ID: <20200607095128.GA6501@xiangao.remote.csb>
References: <20200530161127.16750-1-hsiangkao@redhat.com>
 <20200606081752.27848-1-hsiangkao@redhat.com>
 <0095f9b2-e999-e047-c789-b8ef6c1cea81@aliyun.com>
MIME-Version: 1.0
In-Reply-To: <0095f9b2-e999-e047-c789-b8ef6c1cea81@aliyun.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
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
Cc: linux-erofs@lists.ozlabs.org, Shung Wang <waterbird0806@gmail.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Guifu,

On Sun, Jun 07, 2020 at 05:25:12PM +0800, Li GuiFu wrote:
> It cacuses one build error in my Ubuntu 18.04.1 LTS
> and it seems selinux static lib link cause it
> libtool: link: gcc -Wall -Werror -I../include -g -O2 -static -o
> mkfs.erofs mkfs_erofs-main.o  ../lib/.libs/liberofs.a
> -L/home/liguifu/codes/lz4 -luuid -lselinux -llz4
> /usr/lib/gcc/x86_64-linux-gnu/8/../../../x86_64-linux-gnu/libselinux.a(seusers.o):
> In function `getseuserbyname':
> (.text+0x5e9): warning: Using 'getgrouplist' in statically linked
> applications requires at runtime the shared libraries from the glibc
> version used for linking

Did you apply the following patch as well?
https://lore.kernel.org/r/20200531034510.5019-1-hsiangkao@aol.com/

And then I think you need "make distclean", "./autogen.sh" and
"./configure" again.

Thanks,
Gao Xiang

