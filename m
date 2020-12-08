Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDD762D2933
	for <lists+linux-erofs@lfdr.de>; Tue,  8 Dec 2020 11:49:28 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Cqxks4q39zDqXt
	for <lists+linux-erofs@lfdr.de>; Tue,  8 Dec 2020 21:49:25 +1100 (AEDT)
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
 header.s=mimecast20190719 header.b=Rdgz+Fkm; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Rdgz+Fkm; 
 dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Cqxgk5r7QzDqS4
 for <linux-erofs@lists.ozlabs.org>; Tue,  8 Dec 2020 21:46:41 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1607424399;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6J7yIt7zqDSkwMsxNQ0gl/rypHTz6CfNQjqIdgk+jqw=;
 b=Rdgz+Fkmx4/t6V8CGzMhGqKCXSD7ykE/KCj+l5i+oVwLIQFk92MkkE/9piwvj0c4wyoLC1
 YsTRpwm4i1qlN+bcnMmxZIbW9/zVhL2dOhU/8ejsBxC4g74HeWI/jeARaDLOvnhWcKKtdp
 BFA4FevLA0d5weyhklD4aKPB7V4lDsQ=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1607424399;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6J7yIt7zqDSkwMsxNQ0gl/rypHTz6CfNQjqIdgk+jqw=;
 b=Rdgz+Fkmx4/t6V8CGzMhGqKCXSD7ykE/KCj+l5i+oVwLIQFk92MkkE/9piwvj0c4wyoLC1
 YsTRpwm4i1qlN+bcnMmxZIbW9/zVhL2dOhU/8ejsBxC4g74HeWI/jeARaDLOvnhWcKKtdp
 BFA4FevLA0d5weyhklD4aKPB7V4lDsQ=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-84-Swachz9lOCisMwoGjCqUqA-1; Tue, 08 Dec 2020 05:46:37 -0500
X-MC-Unique: Swachz9lOCisMwoGjCqUqA-1
Received: by mail-pg1-f197.google.com with SMTP id q4so733197pgn.0
 for <linux-erofs@lists.ozlabs.org>; Tue, 08 Dec 2020 02:46:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=6J7yIt7zqDSkwMsxNQ0gl/rypHTz6CfNQjqIdgk+jqw=;
 b=PCoBmim6gAZgXgrAqn5TXY1K1l/wf/S2c04wPh15Isvpu053AKNyFiIiu46sZDmHRR
 9WIEa6YRgp3+wkJucad7j9f50Ogp1uZjDA7girtg11EyMiX6OxebLNN4lmk8ciM1BjAg
 zNe5CqMv2NOmRYSlYCkOTjNsc9HZBLHKsqwSVlEPGmhwD/m9IntFOqJ2Y2Cp1GXQOsqS
 tCpw4+YaACLrD9g1l5NDnxwlfhB2Q/fhmmSm9avecMnBvRayPoWkiZmYY3726NESxJY1
 A8R0wQGqHTtMOlh4NpFHyrJcAnDwCDZQHeVPXu6v112YociKMVnvdvSI37P/iacclugY
 /Aqg==
X-Gm-Message-State: AOAM532sZ46sCHreW1M+GnPF0EQrnSiUEoyrW6dK24f+o7aA9s46uiFx
 duJjV6WmWFN0GYCBli/6ytxvOSv0GNEE0xZ5xHZQmivBKVniJ/8HmeT1Hjq6GyN54QdR+E7/gIv
 NkyhK8U8KTqItdWD5oi1asLI7
X-Received: by 2002:a17:90a:4bc3:: with SMTP id
 u3mr3811438pjl.56.1607424396412; 
 Tue, 08 Dec 2020 02:46:36 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyVoFLWmyxlNZ3rUBYkDhl5XskptEnMXkPhEeVuLOKQuUPkfcUJTENTfIM4P+UeoldLXkZtTw==
X-Received: by 2002:a17:90a:4bc3:: with SMTP id
 u3mr3811421pjl.56.1607424396227; 
 Tue, 08 Dec 2020 02:46:36 -0800 (PST)
Received: from xiangao.remote.csb ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id cl23sm2727416pjb.23.2020.12.08.02.46.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Dec 2020 02:46:35 -0800 (PST)
Date: Tue, 8 Dec 2020 18:46:26 +0800
From: Gao Xiang <hsiangkao@redhat.com>
To: nl6720 <nl6720@gmail.com>
Subject: Re: Cannot build erofs-utils 1.2: multiple definition of `sbi'
Message-ID: <20201208104626.GA3140556@xiangao.remote.csb>
References: <10789285.Na0ui7I3VY@walnut>
MIME-Version: 1.0
In-Reply-To: <10789285.Na0ui7I3VY@walnut>
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

Hi nl6720,

On Tue, Dec 08, 2020 at 12:35:42PM +0200, nl6720 wrote:
> Hi,
> 
> I'm having trouble building erofs-utils 1.2. It fails in "Making all in mkfs":
> 
> /bin/sh ../libtool  --tag=CC   --mode=link gcc -Wall -Werror -I../include -march=x86-64 -mtune=generic -O2 -pipe -fno-plt  -Wl,-O1,--sort-common,--as-needed,-z,relro,-z,now -o mkfs.erofs mkfs_erofs-main.o -luuid  ../lib/liberofs.la  -R/usr/lib -llz4 
> libtool: link: gcc -Wall -Werror -I../include -march=x86-64 -mtune=generic -O2 -pipe -fno-plt -Wl,-O1 -Wl,--sort-common -Wl,--as-needed -Wl,-z -Wl,relro -Wl,-z -Wl,now -o mkfs.erofs mkfs_erofs-main.o  -luuid ../lib/.libs/liberofs.a -llz4 -Wl,-rpath -Wl,/usr/lib
> /usr/bin/ld: ../lib/.libs/liberofs.a(liberofs_la-inode.o):(.bss+0x40000): multiple definition of `sbi'; ../lib/.libs/liberofs.a(liberofs_la-super.o):(.bss+0x0): first defined here
> 
> This is on Arch Linux with:
> binutils 2.35.1-1
> gcc 10.2.0-4
> libtool 2.4.6+42+gb88cebd5-14

Thanks for the quick feedback! since inode.o is for just mkfs, and super.o is for just erofsfuse,
so I didn't observe such issue before with my configuration... I think it may need a
temporary fix for packaging (if erofsfuse is unneeded, since lz4-1.9.3 is needed safely,
is just get rid of the one in lib/super.c, or move these two into lib/config.c....)
I will submit a formal submission later....

Thanks,
Gao Xiang

