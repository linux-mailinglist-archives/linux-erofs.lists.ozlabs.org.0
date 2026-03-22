Return-Path: <linux-erofs+bounces-2932-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QBd+Bw63v2l67wMAu9opvQ
	(envelope-from <linux-erofs+bounces-2932-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Sun, 22 Mar 2026 10:31:58 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id D33842E8B71
	for <lists+linux-erofs@lfdr.de>; Sun, 22 Mar 2026 10:31:56 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fdrff0mVkz2ySb;
	Sun, 22 Mar 2026 20:31:54 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::72e" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774171914;
	cv=pass; b=g77t8baGYTa0j9ObtGSBp2EjjG+T1HrkL0q5sNfDR9FkdGD0/ExVBi2uvnHyFsvBiSccZNADevoL1RCAUyYwTBODy+JpkLJHcngslgeG0uvdGchRPBjXdvPoTmDusEsbaPKgBDruu+wA1EIvOlqsXR6kN74ei17Va9tQ8G/Dr1AA1yKc6ZzX9z92wGdocVajoxOklFmuCdc9OxTO90kZrtrbAB3kuRyGI4W2v0lrR+aiEkElyzUYQ9LruDLzqgJ1bkzBq9tMlq3o9PEB0KKcxFfP6NIObKOp8bB3KskdUAyiUHgC95vyqC9jWidHRvNxTiZTsNcJTb8pHHOB9SnJeg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774171914; c=relaxed/relaxed;
	bh=IhIuUY6BjAXzQnx+l0E8OU1QZFDgiVJRv1Cab9hKY4I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dsyWSJyiUB3Bx+TIZBcRyaDhKBGgy5gnfpigzZSvYqOwMmBXowbwToGcPrzAut2al7RliCFgTP2KRfCD3hlQOvUt4X71KXiLQvXeMxkIWnERVDx0AtWJqZgm8FlJe4CylONVPP5JbeeQkMTb1E8Jb7bjCaXqZphx6ZSG9Lf0hdH9fetfoXQJ0vRZYSKVkL1jjWEkGnryf6bD16/MUwaluS4X1C8EzlFg0KFO/WB2HhWeKzYt09DPXE/YTPxFXZyKScvMYWOp+d9v3Tcjn+VoVbpxCuOlbQnLQ3zRkt7hngThtpjAQJYfosKGQ6tcpacyj7ctKH7KrspEzv49XNwgaQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=dddFsnvn; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::72e; helo=mail-qk1-x72e.google.com; envelope-from=singhutkal015@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=dddFsnvn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::72e; helo=mail-qk1-x72e.google.com; envelope-from=singhutkal015@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fdrfc5wg8z2xlr
	for <linux-erofs@lists.ozlabs.org>; Sun, 22 Mar 2026 20:31:51 +1100 (AEDT)
Received: by mail-qk1-x72e.google.com with SMTP id af79cd13be357-8cfd1cf1748so18007985a.1
        for <linux-erofs@lists.ozlabs.org>; Sun, 22 Mar 2026 02:31:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774171909; cv=none;
        d=google.com; s=arc-20240605;
        b=YRzJ5O+l//vd1V1zjca24l9lJvSwombPpYnnIcgYjZZN7aUgFAUcQ2gJ6SMvCgDoLg
         GPJ+fLedpnMlAgxHxeOt0qB2wlgO8rHaOeYqexa+3gcKZbA1DkPUer9PtKLEedwhgnUg
         do5A7iXciYrGJda32q/h1G1XUhqnjgq5uTesrZMC+7mZeN/YIfsmSeQxktKOyThKgBT1
         MdwLxMVFFXv0nc4RENjpYniDHBIVEFMa1LChJ/u4ZtC2WTEWy6U8sAWH89Iq4d9uN4jA
         J/mbgUtS3qsKUbCnvV4E5/03o3OwlGeaQwXm8VsASPOvGsh21b1DJFvx0qUfDfu9Nv/1
         tFwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=IhIuUY6BjAXzQnx+l0E8OU1QZFDgiVJRv1Cab9hKY4I=;
        fh=QEa+A5jz3A4EPGj7GOn1DhP8Pl0eXTH0mKsXaw490iA=;
        b=F7Xqb1Y/iCTs28bLA8u2n8hYTljo2Pe2DiCGKkcd5k2D4ALhUoq5W4TDL+zqnTtM0w
         1jZPfdSlwEPXLhtvhlC2hHMDrXuTlG0orW5ogBValR9rUMwFgTW86j/oAZWIanVrflE1
         pnTn7262rnfDTOfrJ2/J9Dh8bw4FjkQtQJjmOhyNQbUo0YKVHschBJeFE1HSuDHqn5F6
         5buZ6IEwqrbRpd1+XSCWz5IsHktBbazRZpXgY5T+ikcbyTKjhV+M3iCba6+Yi5uVl1VV
         Gd1BLtxnRCtrV/6rU7gXX8QfUDZ9lE3oGHmwle8DxrsRWm7LnQPDY4u8dogqjxCJQRob
         NZkA==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774171909; x=1774776709; darn=lists.ozlabs.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IhIuUY6BjAXzQnx+l0E8OU1QZFDgiVJRv1Cab9hKY4I=;
        b=dddFsnvnBxDV5FwqrJ987mkzMftedoDA5E+ooiCHAgPaQ4iK9pt03qdGMBVOu3YwhA
         Te79BUVSWlYmGMGWfvOEMkeJ1+9q/XQnfufEiHtTi0ft74QRBZCtvKgyJTgrhbJ/Oh1h
         WfCYkmQknHAR5TUWvqa3zAn+ci4E7m7YP6dGZHjJUGjJTCfWjwv27AZpBfDf/I9b6xdn
         ogZ4Igl3OrQpau7CcmQdPAFtfWcWrVJQh5cYDMZArpaQ2uU0Fgw8DBFxOmBTCC5AqziW
         mQaMfxiNQdSWtTxdxGN4qL8InFbaJBEy9vpg56FdP7KVK2ys6Sb6XF6gWAUq04+kS1d2
         bx8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774171909; x=1774776709;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IhIuUY6BjAXzQnx+l0E8OU1QZFDgiVJRv1Cab9hKY4I=;
        b=LyRcNUgtBktPF56L5YnnYmRCuS3IZxoIsgD4KmUIKad/rWDta/jlbaG7q0FrPtHgnR
         f2OcXNH0h1HIA2lFusy7K9/3M1n5WBjhIox4G1+17V0Up2b1dZxLqvjpcMIBINuhlht3
         cFA9mSgBDESUB9d9Vc2Zkz+zl3N0QdjiAHtUE+CnfHlvYrs300QV9aczfSn9rOCgOzus
         h0Lhx0R3W4qWKVX3rOskk01erLGLkIyhQaBw5kCMs58IcO0vT7jlOZUySYdliglXvear
         7oc32FfQrPXlKNJiDNlNDRgse9LOAD91oBSezQBDtGZMIO2PJOWp6sKZBzm/QT9tAZ5C
         O8Jg==
X-Forwarded-Encrypted: i=1; AJvYcCUYURM0HKQLXHJ/E0TlSMcCCti62V2vRRNQexudNm6BbHKqRZ2DcKibOoal6yRMQuaFIVTDtVJblLlwcQ==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwGIPBqvhKRpY5hBWLdScRyJb0l1nnKMmunGNMYkefgNbjfMcVe
	2wFzp/OMV+X33MzqOOgxp8QcDr4F6KkJKgWM4ASc0MQV+ZLG2Ikrigng/VhY/fdojAneNOIJwYL
	CJixZaP8Opt0ec9ELhReUW4xInrDDQyU=
X-Gm-Gg: ATEYQzyQSVj+nOu+ZeenMY8ivnRnnwQ1W93HEYxKTsMqlvN8plFurrj203g5SKzD8nn
	rhmUuzfQiXgf5tK/xS4+WUeBFI6I/EjNx6BeNwvbCYn8fowXCAAfZSwCfNdBtaUVBQJnT2kb4Rl
	n6xl7yq0gTevu/lodVfsR7NzJQ69VwShxCRUUv55pEG2TZWN7lPgvYrWM9Udhl54B6u3Jc/oIm7
	Jkx9zrMi7V7xGQhOgnKQh7QllZSCXvptXh6ObQFbm15MXjy+UqPmEO6RlBiSAeOejF5kzexkvpc
	gI0cSwcnNnzaEmx7KiJJoQb6plfW6Y6ekY82Tb9ZhnQBKL6nFYynA5/pWlTr+KXbNEeSLg==
X-Received: by 2002:a05:6214:21ce:b0:89c:69f6:a1f4 with SMTP id
 6a1803df08f44-89c85aa66eamr109121776d6.8.1774171908957; Sun, 22 Mar 2026
 02:31:48 -0700 (PDT)
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
References: <20260322083620.19933-1-nithurshen.dev@gmail.com> <20260322085729.24511-1-nithurshen.dev@gmail.com>
In-Reply-To: <20260322085729.24511-1-nithurshen.dev@gmail.com>
From: Utkal Singh <singhutkal015@gmail.com>
Date: Sun, 22 Mar 2026 15:01:40 +0530
X-Gm-Features: AQROBzCXPZxWVPaZM6UhIt449ZvVFGWICGB3iKOQcwTib_BtfDdRxz-YFjLikW0
Message-ID: <CAGSu4WPJ2nvYRUHT-JiPx00RLAmwZS-AzPfzWxn4oiAqLb3zHg@mail.gmail.com>
Subject: Re: [PATCH] fsck: add --workers option to configure worker threads
To: Nithurshen <nithurshen.dev@gmail.com>
Cc: hsiangkao@linux.alibaba.com, linux-erofs@lists.ozlabs.org, 
	xiang@kernel.org
Content-Type: multipart/alternative; boundary="000000000000676865064d9996d1"
X-Spam-Status: No, score=0.1 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,HTML_MESSAGE,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-0.70 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[multipart/alternative,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-2932-lists,linux-erofs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[singhutkal015@gmail.com,linux-erofs@lists.ozlabs.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:nithurshen.dev@gmail.com,m:hsiangkao@linux.alibaba.com,m:linux-erofs@lists.ozlabs.org,m:xiang@kernel.org,m:nithurshendev@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	NEURAL_HAM(-0.00)[-0.998];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[singhutkal015@gmail.com,linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid]
X-Rspamd-Queue-Id: D33842E8B71
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--000000000000676865064d9996d1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Nithurshen,

Thanks for testing the patch and for the detailed feedback.

You're right about the strtoul() wrap-around on 32-bit systems =E2=80=94 I'=
ll
switch to strtol() and add explicit error reporting in v2.

Regarding the design concern: I agree that landing just the CLI
portion without wiring it to the workqueue may be premature. I'll
hold off on v2 until we hear from Gao Xiang on whether this should
wait for the broader multi-threaded fsck design.

Thanks,
Utkal

On Sun, 22 Mar 2026 at 14:27, Nithurshen <nithurshen.dev@gmail.com> wrote:

> As you know, currently decompression process in fsck.erofs is currently
> strictly single threaded. In fsck/main.c, erofs_verify_inode_data
> still processes blocks synchronously via a standard while loop.
> Without wiring this flag to the workqueue engine in lib/workqueue.c,
> the option doesn't currently change the tool's behavior.
>
> And as you know "Multi-threaded Decompression Support in fsck.erofs"
> is actually an official GSoC 2026 project idea and the project will
> likely involve a comprehensive design of the parallelized
> architecture, landing just the --workers CLI portion now might be
> premature or conflict with the eventual design chosen by the GSoC
> contributor.
>
> I'd suggest reaching out to the mentors on the list to see if they
> want to hold off on this patch until the GSoC project kicks off.
> Also, if you do send a v2, switching to strtol() would be safer to
> avoid potential -1 wrap-around issues on 32-bit systems.
>
> Best,
> Nithurshen
>

--000000000000676865064d9996d1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Nithurshen,<br><br>Thanks for testing the patch and for=
 the detailed feedback.<br><br>You&#39;re right about the strtoul() wrap-ar=
ound on 32-bit systems =E2=80=94 I&#39;ll<br>switch to strtol() and add exp=
licit error reporting in v2.<br><br>Regarding the design concern: I agree t=
hat landing just the CLI<br>portion without wiring it to the workqueue may =
be premature. I&#39;ll<br>hold off on v2 until we hear from Gao Xiang on wh=
ether this should<br>wait for the broader multi-threaded fsck design.<br><b=
r>Thanks,<br>Utkal</div><br><div class=3D"gmail_quote gmail_quote_container=
"><div dir=3D"ltr" class=3D"gmail_attr">On Sun, 22 Mar 2026 at 14:27, Nithu=
rshen &lt;<a href=3D"mailto:nithurshen.dev@gmail.com">nithurshen.dev@gmail.=
com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1e=
x">As you know, currently decompression process in fsck.erofs is currently<=
br>
strictly single threaded. In fsck/main.c, erofs_verify_inode_data<br>
still processes blocks synchronously via a standard while loop.<br>
Without wiring this flag to the workqueue engine in lib/workqueue.c,<br>
the option doesn&#39;t currently change the tool&#39;s behavior.<br>
<br>
And as you know &quot;Multi-threaded Decompression Support in fsck.erofs&qu=
ot;<br>
is actually an official GSoC 2026 project idea and the project will<br>
likely involve a comprehensive design of the parallelized<br>
architecture, landing just the --workers CLI portion now might be<br>
premature or conflict with the eventual design chosen by the GSoC<br>
contributor.<br>
<br>
I&#39;d suggest reaching out to the mentors on the list to see if they<br>
want to hold off on this patch until the GSoC project kicks off.<br>
Also, if you do send a v2, switching to strtol() would be safer to<br>
avoid potential -1 wrap-around issues on 32-bit systems.<br>
<br>
Best,<br>
Nithurshen<br>
</blockquote></div>

--000000000000676865064d9996d1--

