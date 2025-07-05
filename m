Return-Path: <linux-erofs+bounces-531-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12418AFA00F
	for <lists+linux-erofs@lfdr.de>; Sat,  5 Jul 2025 14:35:03 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bZ91s63Fjz2y06;
	Sat,  5 Jul 2025 22:34:57 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::629"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1751718897;
	cv=none; b=g+uo15StO5T62O9TQGPSj/PGKc69smcqf5a//mFZZqJcD1vN5wKYMalIcliVkhBpLt/nYZeZwNNS70OKE9bJk7TDt3i0bIAgNupHBpiFpsAGzM1JiV4Upor+gyJBhsCHJttWRTBzyDDCwIPtXE6g1jMB6IMomtRiFQy1Y6H91oXguQuBVHwMDeBqSDzxJ545cWxHzplRqfJsWf32Y+3yZ+sO3ByuH9Hgi1X7wPFrP6GxPXtkytXALlv3XnSOV1WV2aoIE0l9u2dZzNwgWMrV3UBKLdSHxitF0oyeIOXxbD+oJwmWWGmKYXPZayS6iGvsoC6Fjip+CStc71HKHrH7UA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1751718897; c=relaxed/relaxed;
	bh=vpyXO57bBET1Pab9NO2wsnBICdVzhwypL8+QZnPYDFk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BpFtou7/pTi3ANdCL/G33U34slUOtIwm/8YXHeZTEFU8J24CNF2eIt+hlGRFFW67dz0uBmaYTHKszbw+rpKOox4T++5/wen/xp5acceaKqNgxpI4eizFavzVa+c2bR58ZBYC3fhTpDV787KL5jzMdaDMA7mI8VmGeNzaHbpaV4Hl7DBE5azl9xuxrAlSIz+szFmlR+ynfeHt/eNmDseOIJ/8XU7aPZ6rzl7zW7bPebV05TkLizkMij21kWYBXLALzXvNoMKNtBvcGxMdwe0//AHWjQtLRybuMafMTn2YfxG7n2ZkDSEtx6Ck+xRM99M9luyVjcPQXijXmuc0vCy8Pw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=P8YmNuyn; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::629; helo=mail-ej1-x629.google.com; envelope-from=amir73il@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=P8YmNuyn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::629; helo=mail-ej1-x629.google.com; envelope-from=amir73il@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bZ91r1Lvfz2xQ4
	for <linux-erofs@lists.ozlabs.org>; Sat,  5 Jul 2025 22:34:55 +1000 (AEST)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-ae0dd7ac1f5so310963866b.2
        for <linux-erofs@lists.ozlabs.org>; Sat, 05 Jul 2025 05:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751718891; x=1752323691; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vpyXO57bBET1Pab9NO2wsnBICdVzhwypL8+QZnPYDFk=;
        b=P8YmNuyncnw7YMNINeWCEC0ymM+WUHZUgG461P+CGbfkSj/MhgYhAd22FtarHLksdf
         CklBwPmFqJKHBx5qxXwph4c+NX+elafYNREAFZN+Oy0bg2YvwXw+pe78BR4pHZLrlLRt
         xc6h7i7/VZsjWwYuKG+48qXJqFD3jif4U8adUmHQ1fiUOB6iSX+jOFFUgzifMYrtFA/2
         QeMHVOC5lwQOiNXXaaZbJ5p4EiVJSaPwKFi+Ty2HTJWP/Kow5aNZX2b4e6cklq7Qd+MQ
         a7teHvD1Kic+KmBt6ywtI3DVDjYgjGw/yrxBTCu83h+Z5tfQ5xTaVhk+ZZqP1qjJGzsX
         UUBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751718891; x=1752323691;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vpyXO57bBET1Pab9NO2wsnBICdVzhwypL8+QZnPYDFk=;
        b=c+mYTeq1+KJ3F3nX0sKz7jdDUF86OkRBhn2Dbx8NQz3takq7X15eSMiM+Y6C+6GS+L
         DkEJ6IBB9Jv3USEV/RrNf9nSpA2Km7zVKY6WkQy16+oeXklmpY9WlaWf/ck8LDHFQLDc
         8QJnSgo7JdNzi2V8BcydAUBy8DrnWMWuzRKaXhDgJEH9Q196G6QnzdGO45uzC/w2r0nw
         FpDGksTYeVQG4+9rte2N7iF1foEI1tGhkXZEfgFB0uOhFx9y09BMgxlJHJDIAwey5dz9
         xwVRVfKWr7MhIHLGq/UKrsvmACy3VwVPjKyifd1+nrNV4FjfXomtCRkQJX6Do4Dra7Fo
         nHRA==
X-Forwarded-Encrypted: i=1; AJvYcCW8C9EQSKAwV6dDAorAykBkmIoyjWXapqlNqo/JWfEJ7gSlz+kwKEpD9WsiG4Jh00lld/qCGd41W0lCTg==@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yy2D2HG1T4aXY1Ocd+Mh7l4CXWx4M9DzmVEAnc+9umIX0uVDciG
	wDZ8KR4ua9D1J7TAtSLXB1ON15qXKgUnJsJ178yc+0JZ4V2WlQn1QG8qRcQsJ2nah589QBcSHdW
	IqsqPpQsC4lYrc8uGllWxF4XfCh//A7g=
X-Gm-Gg: ASbGncvPhbyT1YB1Psuzt8Q/UGWPnj1OHoDQdx5GD4Fnb92B0y3RpifaSqvNd0P7WLe
	yVVmX6/BJeuucySNIkXDHdP1vEXU8AghUu2Cjr0Fre8hdqvHcBLMJEGCnRlP9gueyrr4gy5KBoP
	8q29a22PCvN0R05k3XUsoePhjhSko0Ymr5gjK6TCPw8+PYeE4UCzw6dA==
X-Google-Smtp-Source: AGHT+IFfEMpmUnwDLF2Ii9Con+rmNnaYtyjh73pvz0kleujwRFvAKyqIXEk+K3I6ZLDCPtmmVUlp1aBdyzD/pOBXfuo=
X-Received: by 2002:a17:907:7293:b0:ae3:5368:be85 with SMTP id
 a640c23a62f3a-ae410a27ed3mr190247866b.47.1751718890123; Sat, 05 Jul 2025
 05:34:50 -0700 (PDT)
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
References: <20250703-work-erofs-pcs-v1-0-0ce1f6be28ee@kernel.org>
 <20250703-work-erofs-pcs-v1-2-0ce1f6be28ee@kernel.org> <12e59170-7435-4fae-a485-9cb105c378d1@linux.alibaba.com>
 <CAOQ4uxhhDS2XAKNnENEWfDrbp6+SX7Q_BY9OLo4QA4Jf0fHuvw@mail.gmail.com> <33817204-2455-4b8b-940e-072fad58191d@linux.alibaba.com>
In-Reply-To: <33817204-2455-4b8b-940e-072fad58191d@linux.alibaba.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sat, 5 Jul 2025 14:34:39 +0200
X-Gm-Features: Ac12FXxLgwVy9IiGDUq0pn7e2aRcab0k2uIvQfBW6_kubb-04jzCoLdty12mXxk
Message-ID: <CAOQ4uxjFcw7+w4jfjRKZRDitaXmgK1WhFbidPUFjXFt_6Kew5A@mail.gmail.com>
Subject: Re: [PATCH RFC 2/4] erofs: introduce page cache share feature
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Christian Brauner <brauner@kernel.org>, Hongzhen Luo <hongzhen@linux.alibaba.com>, 
	Daan De Meyer <daan.j.demeyer@gmail.com>, Lennart Poettering <lennart@poettering.net>, 
	Mike Yuan <me@yhndnzj.com>, =?UTF-8?Q?Zbigniew_J=C4=99drzejewski=2DSzmek?= <zbyszek@in.waw.pl>, 
	lihongbo22@huawei.com, linux-erofs@lists.ozlabs.org, 
	Gao Xiang <xiang@kernel.org>, Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@kernel.org>, 
	Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

On Sat, Jul 5, 2025 at 12:58=E2=80=AFPM Gao Xiang <hsiangkao@linux.alibaba.=
com> wrote:
>
> Hi Amir,
>
> On 2025/7/5 16:25, Amir Goldstein wrote:
>
> ...
>
> >
> > 2. When is it ok to use the backing_file helpers?
> >
> > The current patch allocates a struct file with
> > alloc_file_pseudo() and not a struct backing_file,
> > so using the backing_file helpers is going to be awkward and
> > misleading and I think in this case it will we wize to refrain
> > from using a local var name backing_file.
> >
> > The thing that you need to ask yourself is do you want
> > backing_file_set_user_path() for the erofs shared inode.
>
> Yes, agreed, that should be improved as you said.
>
> >
> > That means, what do you want users to see when they
> > look at /proc/self/map_files symlinks.
> >
> > With the current patch set I believe they will see a symlink to
> > something like "[erofs_pcs_f]" for any mapped file
> > which is somewhat odd.
>
> Agreed.
>
> >
> > I think it would have been nice if users saw something like
> > "[erofs_pcs_md5digest:XXXXXXX]"
>
> But if we use `overlay.metacopy` for example, it's not
> a string anymore. IOWs, I'd like to support binary
> footprint too.
>
> And I tend to avoid md5 calcuation or something in
> the kernel.  The kernel just uses footprint xattrs
> instead.
>
> > IMO, making the page cache dedupe visible in map_files is
> > a very nice feature.
> > > Overlayfs took the approach that users are expecting to see
> > the actual path of the (non-anonymous) file that they mapped
> > when looking at map_files symlinks.
> > If you do not display the path to erofs mount in map_files,
> > then lsof will not be able to blame a process with mapped files
> > as the reason for keeping erofs mount busy.
>
> I think users should see `the actual path` rather than
> "[erofs_pcs_xxxxx]" too, but I don't have any chance to
> check this part yet.
>
> If it's possible for overlayfs, I guess it's possible for
> erofs page cache sharing, maybe?
>

Yes, I am sorry if that wasn't clear.
If you want the map_files to show the user mapped file's path,
you can use the backing_file helpers and more specifically
backing_file_open() and all should work as in overlayfs.

Obviously, you'd need to wrap the back_file helper with
erofs specific logic, such as don't allow dio and such.

Thanks,
Amir.

