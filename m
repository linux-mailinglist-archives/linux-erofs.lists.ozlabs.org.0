Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 56D21988B98
	for <lists+linux-erofs@lfdr.de>; Fri, 27 Sep 2024 22:55:24 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XFjQt4Xtbz3cR3
	for <lists+linux-erofs@lfdr.de>; Sat, 28 Sep 2024 06:55:18 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::429"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1727470516;
	cv=none; b=f35mNAEtsF4HdBJp08sPS/Xyfu2i4aMG7qC+AXx8G1uJ1Sh+1YgsBS1xZh3O3V9YRJeibFDdZ0z8YMofPzx3RK8I2vFMrgK2KiOqhmYjTUIj1d2z/rxQmY1XWfCiJUrm09/SMu+Pu9EKXn5ULw18p1Iidd9krdweSEg+SiPE5odpTgwIt9hi8e9DPqURuBcs0Q9y2tAD8+bzq/HxhN9dscuhuOTrAiUCZZeSqvDYfm+WdT/GQVFX37F/7wDspD+61r1hSMw6T9Jvsi5AuClr1AD3uRvYceacfT+ehpgd1SQs2/Qba1+hPk/5dVRydHSN7vbzn/1HvcgesFpwcOZT7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1727470516; c=relaxed/relaxed;
	bh=Jc3nYk2509qhCNS0ikpWjFw1TBPnAAPbAzygg09FB9o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IpSiGTonhOXcMjjSiQp+/Ue2F7LGwwmNOhvHkSj4uvAfgIQ31QpiYgqsWbP5K+wS/pSNfL9Sd3QtvJKJnCNTTI+/5a3OdNzzDLjiD5TD70s3S0Cm3uQtCR0C2ItccFOswDX2VfPbRVdLrmnCZyNm1T1+VlzGR7xVxg5ysoF1TuOIFgntaSTUo2Cscdly1BYf2WmID4Ws8L8hqJpW/UdJNWHKL1DSgjST9qhNBZkI6UTXzdih9olLS1ieSYQ3XiAaIBMB8msuyKUv9ft/L+Frvo0uCn/LPhZbOkJAXP3PqK7l9vgvNp221HZt4nqGmucMUYyv2ykqNQVkVSJxxlQUnA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Fpkzl4j/; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::429; helo=mail-pf1-x429.google.com; envelope-from=eddyz87@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Fpkzl4j/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::429; helo=mail-pf1-x429.google.com; envelope-from=eddyz87@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XFjQq5SsRz3cNl
	for <linux-erofs@lists.ozlabs.org>; Sat, 28 Sep 2024 06:55:14 +1000 (AEST)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-7179069d029so1914008b3a.2
        for <linux-erofs@lists.ozlabs.org>; Fri, 27 Sep 2024 13:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727470512; x=1728075312; darn=lists.ozlabs.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Jc3nYk2509qhCNS0ikpWjFw1TBPnAAPbAzygg09FB9o=;
        b=Fpkzl4j/nJMUJ9VRIVWktZ+FlmILgibzZWkuvcPFvs5V5N4CHaSIZuK29UsnJI7H/Y
         UyagmJdajBxpRt2gL0onvacN552r7thhTS6FFkdAFFhjs+6hlvaHFKtkNgnSm2hVJ4B3
         zWiZ5ONEoGQ4LSEC0KEvQO5f2SSSDwa1zIy54DspMDpgyeFVHRcsMOvCP2kkeDpgGvDk
         vq8DDxlBw5MUPloMjdigWCTQ0gBY/MpLIWRCdvDobidCZuRzJjXCDdgp9pzm4jDyHzHA
         jt4yPqIW7J23LvJBjlpGwHql00i97BqD08/YYbO1+bbIVpJvXmokfZVaVWxTgUoZeZBV
         /KjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727470512; x=1728075312;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Jc3nYk2509qhCNS0ikpWjFw1TBPnAAPbAzygg09FB9o=;
        b=gllQlThmYPL/tEgz95ilqbL9QWCTDjpvqqilZ4P1iFwb875yFI3dtYCovroLPE8MZg
         dUBVHWXX7aJsBd/aZ5olzEKq8VR6Yx/+c6uhiuBgAe60eY3orSJfWECyOeWYRWzN24Cm
         n78v4wOza8v+csWpF5mPu109q8TmqQKtNvFxOxenttKabGzHjAANwyc2wbFpmfgo4CVL
         CQ1shSjHyjtKO4va1fY9zKQftk3Cr5MuRy69cbwoYQj1lRliE4DmsSB9UOl9VxmVpGO8
         NhBN3sRh4uXG1hAtbjH0H90LSdfGj9x2OR5M+d+4/gmoypUIlD6Vbx8nPoWKswKZWMSy
         N1sg==
X-Forwarded-Encrypted: i=1; AJvYcCWDcjaRc9ZBjB0R4EVhCC+q+rO3StkVbYTbkzswNtCqNDoV0MSVe1Csz9d2IGszVmoO/cUDyDe6SvDMpw==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyXi4NZLz1pAFQXkbbFK9ZBOO6OHDCFeWpE5eJMlxJlTPwfLK1t
	q6jr3JYcEx7iupjnRX5/JA9LmDUs5AOPrFx2R4d6cWzt2qjQWToK
X-Google-Smtp-Source: AGHT+IG97WQ0sKf6nP3kVcYM7xIWbrZHObvDCRA4X7I+pJRt7WQ0LRz1ytlfbrB+m9K1oZ0O2AT5Aw==
X-Received: by 2002:a05:6a21:1690:b0:1cf:4422:d18b with SMTP id adf61e73a8af0-1d4fa694d0bmr5811129637.14.1727470512137;
        Fri, 27 Sep 2024 13:55:12 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b26536b46sm2025461b3a.193.2024.09.27.13.55.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2024 13:55:11 -0700 (PDT)
Message-ID: <55cef4bef5a14a70b97e104c4ddd8ef64430f168.camel@gmail.com>
Subject: Re: [PATCH v2 19/25] netfs: Speed up buffered reading
From: Eduard Zingerman <eddyz87@gmail.com>
To: David Howells <dhowells@redhat.com>, Manu Bretelle <chantr4@gmail.com>
Date: Fri, 27 Sep 2024 13:55:06 -0700
In-Reply-To: <2663729.1727470216@warthog.procyon.org.uk>
References: <20240923183432.1876750-1-chantr4@gmail.com>
	 <20240814203850.2240469-20-dhowells@redhat.com>
	 <2663729.1727470216@warthog.procyon.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
MIME-Version: 1.0
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
Cc: asmadeus@codewreck.org, linux-mm@kvack.org, marc.dionne@auristor.com, linux-afs@lists.infradead.org, pc@manguebit.com, linux-cifs@vger.kernel.org, willy@infradead.org, smfrench@gmail.com, hsiangkao@linux.alibaba.com, idryomov@gmail.com, sprasad@microsoft.com, tom@talpey.com, ceph-devel@vger.kernel.org, ericvh@kernel.org, christian@brauner.io, linux-nfs@vger.kernel.org, netdev@vger.kernel.org, v9fs@lists.linux.dev, jlayton@kernel.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, netfs@lists.linux.dev, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Fri, 2024-09-27 at 21:50 +0100, David Howells wrote:
> Is it possible for you to turn on some tracepoints and access the traces?
> Granted, you probably need to do the enablement during boot.

Yes, sure, tell me what you need.
Alternatively I can pack this thing in a dockerfile, so that you would
be able to reproduce locally (but that would have to wait till my evening).

