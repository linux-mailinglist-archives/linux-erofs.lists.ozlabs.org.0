Return-Path: <linux-erofs+bounces-3144-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0KyGLkjUy2mILwYAu9opvQ
	(envelope-from <linux-erofs+bounces-3144-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 31 Mar 2026 16:03:52 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5D3436A9FA
	for <lists+linux-erofs@lfdr.de>; Tue, 31 Mar 2026 16:03:51 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4flVGD6dm4z2ybR;
	Wed, 01 Apr 2026 01:03:48 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::1336" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774965828;
	cv=pass; b=W6CjZRNKvwaKtRGdi2amajk5JbyBB1xMIm75nmTfghhpVSEFmKsgRGGPPd7tnXYe4a7RxtTCaGKiIuAj92+on4t1pQHYrnQCcC0o1BgJMsTF+Pt2BdyanUvxG4oXmpY1CNIZNA0CPlbUghX77tcGwWtOCSSisxsFVevoiGbW0dtzF8tzltmuNdwE5WoPzuGu+kgsBMc+x+UygoQjJzVWjM4eKf0d58+vb+uCl7I8HvDjOk/aw1/zciWpqtVAOBVoj/EDPMSRKp/cLLv5DQb/2c+TJaHpVVUOps+jLtVRFpRD3bnLlR9Ipv/kX52+92guPMcw84Uj5LkFNEc7gVYZuQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774965828; c=relaxed/relaxed;
	bh=vyvhTs1OicliWu+WtWpV4638VOyupuZR7VYdwSTf7iM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=S5WWRySZcyVuWlIeSx3Mndj1s/IEdyQpweYbNEyltB/CMDk9xH0Uug0ToEJyvMG8nENc2uD2oP0kMQR7cnznzXrWOeczy+j+vOajcIScpVkwp0CkuNwAGLXnUE0vfiOlJhHHE9cCjjlBhqqxegPA84RDwx8ejXZm0L8wVTXJDvIliK3zpIz9ZAIjXjRs507PlFwdeIhXVG7S3DlJPiy5RSO+L2NPmCl3WcHstQnBvYUSjmc8+VHRRpeeDaREy4m/QLFIvkTsb/ziQxRjtnuz4Z15GIKyk8g0nEYccbC427ZYUAYI3UzJjZptYhKhTsgUpkEYwYQOG2wYmB/YZ3lajA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=W8FEtGEL; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1336; helo=mail-dy1-x1336.google.com; envelope-from=yashgupta9437@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=W8FEtGEL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1336; helo=mail-dy1-x1336.google.com; envelope-from=yashgupta9437@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x1336.google.com (mail-dy1-x1336.google.com [IPv6:2607:f8b0:4864:20::1336])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4flVGC5nsyz2ybQ
	for <linux-erofs@lists.ozlabs.org>; Wed, 01 Apr 2026 01:03:47 +1100 (AEDT)
Received: by mail-dy1-x1336.google.com with SMTP id 5a478bee46e88-2b6b0500e06so7629745eec.1
        for <linux-erofs@lists.ozlabs.org>; Tue, 31 Mar 2026 07:03:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774965825; cv=none;
        d=google.com; s=arc-20240605;
        b=d06FmKYfU9WejqK1Ma82Is6axVe+e5JXsjrGnr7bAJZbZOEyhYtiz5O7tWb4QL1FXR
         Tf9xm9+2AwZuWhvciud2DU25Spfq5l0RG2qmL3MNsynlOrUxk8fAOk5m4xu0AQlJzpRh
         Rim8YzcQcPoLSR1XCDvWQXd4vPhduekO246sMtME9hDQIdWG6jJyLLRpFyw8wi26N5C3
         1cjpMbS1qkx970zI9+/xQFqEjN8sbZh8D6/W5xCrtHG79StwpPRKWObC93od+LJq3HDR
         XS3cJ8WNpc9on4ugs0Y2pTx4Nk3eYOV9gPvwEb1qipwV2ujVaE7ZyhMoWldzHVlCqcyq
         kCSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=vyvhTs1OicliWu+WtWpV4638VOyupuZR7VYdwSTf7iM=;
        fh=wOhGMmq2KH+KOElLlPuS8ws9o9ArjDb4wH58JVHh4Vg=;
        b=ZlsLpzKh/0dAO2+vBMuUx+V1r5qWl3EZkbbPcO98U9amw44qf2+iBZuVH4jznWbaEU
         4maiIYMdmMx/eLyIIB4mR2Yv4YsymgXlDCDmsrNyZxoNKtjnIzhdE5R6AckOSmr080VI
         uPznH1ZEmACX1gdORKSlCkbRPUrlU0MYV+ZNyXCT7pk2Nts2A3ef6zJ6/Yah3B5571DK
         F/zpr7ia5PQNmJ762sd+a/otOEWKb8D3N6SdQxW6CDEiQetV+c+2ytEMjDk+iAJpcxEd
         o5yyVl2wfb3d+x+t5X08yJNRcCKdOxOkajBsOCayUfS9Gz2msZBSlJNKLPnx2nDm2vdt
         9OVQ==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774965825; x=1775570625; darn=lists.ozlabs.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vyvhTs1OicliWu+WtWpV4638VOyupuZR7VYdwSTf7iM=;
        b=W8FEtGELE9vtZDLRF1rCYQpgbjXrWuIDK4m60n35lwrIQOom3U6zcahhPSdJcDuMCt
         DObvVQGAuYPm7vjNBdIH9uQ7nPJMr18YDuVGiim4p6Wy1kq4Q38Ifey3S7egna1Ztmjo
         1+Hhgj6NJEgS7OU0twdGmhQqPlwaxBVHxu17Ct/+sKlN5XEEKzID1jdaVXp0KWJkp1kZ
         38iDLEop5yLDXqnRUYQpdUdoJGZi819bjt/6ZyLLrEaJtzUz/HrMhmKHh967tagiLbDq
         2XFIhFbe2gJTr97lioCfyowt9E9IVDtpzpI0FJdn+8J4CVicCWhMeled3vurRkquQ1Ed
         U20w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774965825; x=1775570625;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vyvhTs1OicliWu+WtWpV4638VOyupuZR7VYdwSTf7iM=;
        b=NSuG9TMq69i7IH+tjnF6ddwd46BJfd2BGm8t30nhBzACMfclCV4jYlK08tHTqU2Of/
         9dHQo2iRgzH4pQpjPH2wsnP5gQr133VmE07Z5uz8gBjYrXRwWOh6vouYvxe8ZLPJUFly
         h/uZOv/Zky8K5A5Zh53HHPmsr+EQJEZi+lXHkTqOseGdbPDaoFABkQuO4da8Pzw/Eet2
         XCyDP5PUJaSCy77omQBe+0X0O/95mo4JKiX7XHaplTN+aaCO+c1DjWr33jB5j/bEjNOL
         PQ0yyhnB+Da3Kl1h4OoBoqI6ye1nzr81LYEfpOLSeGUhNUvTSoJ9eq6/r+ASOgEip0Ee
         GFhg==
X-Gm-Message-State: AOJu0YyNlgj2JzbRFXhDmNr0u9q12JsZ4+FrtvEsM9Y9PGjbMH5fKSJT
	KM6rqUlvDxFE3jdFBgyZ50zQ8zB2Rv92tfHMCE4TZgZGNCYFFSLX6nL+fuF7ztS66Qu7oI8KnE2
	88Ug9MUy9mGAeyA28wNGa+l7jLXNRGnoCNvt3FoI=
X-Gm-Gg: ATEYQzwnWuvWCABs3b9s4eYIHN09fAzjgmMNsgiclxE0J8i+fqyZXj8PmveBZEC7q1v
	LV3s/JltuAx3BLndCUVMkY2LX0f95qsM+nKyx/5zKZAoSW6mPpmxS+zC3DukBH5tXWVGSg9ygLy
	cCvHtpLFugeZoa8+vWHSPQwIs27h+yHPfQg/GylQ2Xo468nTBsMFCaevFp5R3n8x+oJC8diph8o
	/ZztwxQD+z9MlxSR/smFfaywb71QaoAHGLcO7I/LnhFvYp7iGA536qAEpXc0hGPItRPv2R7+7MR
	k9+evA==
X-Received: by 2002:a05:7301:129b:b0:2c0:c767:b6b with SMTP id
 5a478bee46e88-2c185f58b3bmr8592582eec.32.1774965824532; Tue, 31 Mar 2026
 07:03:44 -0700 (PDT)
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
From: Yash Gupta <yashgupta9437@gmail.com>
Date: Tue, 31 Mar 2026 19:33:08 +0530
X-Gm-Features: AQROBzAy7TRo5tgIB1VqbPl4Mywmpj99P7qmqYegYRzudnjqrQPwtuZucUiXQwE
Message-ID: <CAJ-i-wEroK3Yx-6h7dydGECqVO_Xh7hOvFAS-M75MO98_QKjog@mail.gmail.com>
Subject: =?UTF-8?Q?=5BGSoC_2026=5D_Introduction_=26_Proposal_Discussion_=E2=80=94_f?=
	=?UTF-8?Q?sck=2Eerofs_Multi=2Dthreaded_Decompression?=
To: linux-erofs@lists.ozlabs.org
Content-Type: multipart/alternative; boundary="00000000000075b463064e526f1b"
X-Spam-Status: No, score=0.1 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,HTML_MESSAGE,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-2.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[multipart/alternative,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-3144-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	RCPT_COUNT_ONE(0.00)[1];
	FREEMAIL_FROM(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	MISSING_XM_UA(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	TO_DN_NONE(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yashgupta9437@gmail.com,linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-erofs];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,linkedin.com:url,ozlabs.org:email,lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: A5D3436A9FA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--00000000000075b463064e526f1b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

 Dear Yifan, Chunhai, and Gao Xiang,

I am Yash Gupta, a second-year MCA student at Chandigarh University, India
(IST, UTC+5:30). I am writing to introduce myself ahead of submitting my
GSoC 2026 proposal for the "Multi-threaded Decompression Support in
fsck.erofs" project.

I have studied the three problems documented openly in the erofs-utils
README =E2=80=94 single-threaded extraction, slow fragment decompression, a=
nd
missing xattr/ACL restoration =E2=80=94 and my proposal addresses all three
directly.

Preparation I have done so far:

- Built erofs-utils from source on Fedora 41 and Debian 13
- Profiled fsck.erofs --extract on sample images using perf and confirmed
the single-threaded CPU bottleneck firsthand
- Traced the pcluster decompression call path end-to-end through fsck/ and
lib/
- Reviewed the mkfs.erofs thread-pool implementation as a reference for
pool design
- Read the containerd EROFS snapshotter documentation to understand how
EROFS layer blobs are consumed downstream
- Subscribed to linux-erofs@lists.ozlabs.org and reviewed the last three
months of patches, including commit 2ce4b18 (xattr crash fix in the rebuild
path)

My proposed technical approach:

- A fixed-size pthreads pool (default: nproc, overridable via -j N) with an
MPMC work queue
- Pre-allocated, non-overlapping output buffers per inode =E2=80=94 no lock=
s needed
at write time, zero coordination between worker threads during decompressio=
n
- A reader-writer-locked hash-map cache keyed by pcluster disk block
address to eliminate redundant fragment re-decompression
- xattr and ACL restoration via lsetxattr(), built on the stabilized
2ce4b18 base, covering SELinux labels, file capabilities, and POSIX ACL
round-trips
- TSAN validation on every patch before sending upstream

I have practical experience with POSIX pthreads, producer-consumer queues,
and reader-writer locks from coursework and personal projects. I am
familiar with git format-patch, git send-email, Linux kernel coding style,
and checkpatch.pl.

I plan to post baseline benchmark numbers to the mailing list during the
community bonding period before writing any code, and to send incremental
patch series for review throughout the summer rather than a single large
batch at the end.

My proposal draft is attached. I would greatly appreciate any early
feedback =E2=80=94 particularly on the thread-pool design, the fragment cac=
he
approach, and whether the 12-week timeline is realistic from your
perspective.

Thank you for your time and for maintaining such a well-documented project.

Best regards,
Yash Gupta
MCA =C2=B7 Chandigarh University =C2=B7 India
github.com/developer-yashgupta
linkedin.com/in/developer-yash
yashgupta9437@gmail.com
IST (UTC +5:30)

--00000000000075b463064e526f1b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">=C2=A0Dear Yifan, Chunhai, and Gao Xiang,<br><br>I am Yash=
 Gupta, a second-year MCA student at Chandigarh University, India (IST, UTC=
+5:30). I am writing to introduce myself ahead of submitting my GSoC 2026 p=
roposal for the &quot;Multi-threaded Decompression Support in fsck.erofs&qu=
ot; project.<br><br>I have studied the three problems documented openly in =
the erofs-utils README =E2=80=94 single-threaded extraction, slow fragment =
decompression, and missing xattr/ACL restoration =E2=80=94 and my proposal =
addresses all three directly.<br><br>Preparation I have done so far:<br><br=
>- Built erofs-utils from source on Fedora 41 and Debian 13<br>- Profiled f=
sck.erofs --extract on sample images using perf and confirmed the single-th=
readed CPU bottleneck firsthand<br>- Traced the pcluster decompression call=
 path end-to-end through fsck/ and lib/<br>- Reviewed the mkfs.erofs thread=
-pool implementation as a reference for pool design<br>- Read the container=
d EROFS snapshotter documentation to understand how EROFS layer blobs are c=
onsumed downstream<br>- Subscribed to <a href=3D"mailto:linux-erofs@lists.o=
zlabs.org">linux-erofs@lists.ozlabs.org</a> and reviewed the last three mon=
ths of patches, including commit 2ce4b18 (xattr crash fix in the rebuild pa=
th)<br><br>My proposed technical approach:<br><br>- A fixed-size pthreads p=
ool (default: nproc, overridable via -j N) with an MPMC work queue<br>- Pre=
-allocated, non-overlapping output buffers per inode =E2=80=94 no locks nee=
ded at write time, zero coordination between worker threads during decompre=
ssion<br>- A reader-writer-locked hash-map cache keyed by pcluster disk blo=
ck address to eliminate redundant fragment re-decompression<br>- xattr and =
ACL restoration via lsetxattr(), built on the stabilized 2ce4b18 base, cove=
ring SELinux labels, file capabilities, and POSIX ACL round-trips<br>- TSAN=
 validation on every patch before sending upstream<br><br>I have practical =
experience with POSIX pthreads, producer-consumer queues, and reader-writer=
 locks from coursework and personal projects. I am familiar with git format=
-patch, git send-email, Linux kernel coding style, and <a href=3D"http://ch=
eckpatch.pl">checkpatch.pl</a>.<br><br>I plan to post baseline benchmark nu=
mbers to the mailing list during the community bonding period before writin=
g any code, and to send incremental patch series for review throughout the =
summer rather than a single large batch at the end.<br><br>My proposal draf=
t is attached. I would greatly appreciate any early feedback =E2=80=94 part=
icularly on the thread-pool design, the fragment cache approach, and whethe=
r the 12-week timeline is realistic from your perspective.<br><br>Thank you=
 for your time and for maintaining such a well-documented project.<br><br>B=
est regards,<br>Yash Gupta<br>MCA =C2=B7 Chandigarh University =C2=B7 India=
<br><a href=3D"http://github.com/developer-yashgupta">github.com/developer-=
yashgupta</a><br><a href=3D"http://linkedin.com/in/developer-yash">linkedin=
.com/in/developer-yash</a><br><a href=3D"mailto:yashgupta9437@gmail.com">ya=
shgupta9437@gmail.com</a><br>IST (UTC +5:30)</div>

--00000000000075b463064e526f1b--

