Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D2BFA06412
	for <lists+linux-erofs@lfdr.de>; Wed,  8 Jan 2025 19:15:24 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YSx0n16D4z30fM
	for <lists+linux-erofs@lfdr.de>; Thu,  9 Jan 2025 05:15:21 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1736360119;
	cv=none; b=bszGuN9vrMRtPpkWq+bsiGplugbRzC4ufYKN/CbLr8A+rw93CFNLW7X8/24+ZC2vo3L+Iw81phV8qg4qzoy3CKr+R48HCGgWuH3unZM1m9XlhgcWeCzLRhSPtN8E80+fq/k8e2292oIK3MspiinUUhLBU7Zi/OU9owWrvNk5DwDahxe3+LmylNaTxtweXksj/YMrvpLUXkECvloDhwoZ8p1iKD8ENnjezZY7FWs/qZPYBj2Ke5UZwxKCDvkg6UUj/nwBNXa2YUatFGMgRdwvcZP6fHnZl7vRdWI/tRIydDkUtiQTOKYnQf/lnigNjjVfjnXZ+qn3PqJtGJ9uabUhdw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1736360119; c=relaxed/relaxed;
	bh=maJsQJJ4eznzeJRr5m3kakizm9g83vtAwXej/TfFIcU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=gLPwWLpA/JUCmDkS2xVuiB8e+njYQOQci1/0ZdjyjdE6UuDYtt2CgKcUZosi9rQurpG9uJiTGtgzUkbDjFk40kajxXx6SCeeFKinBGKqx9+HzVx4O3pqs113dhzT3C/aTYB2AB2LRUt9BeMBYWY8O1XWHWGW8WM2724ZgJ10EJwqr0uD6aSdsw3xG7bH0J7cJgh6sGRZ6GFWFumfhO8lifeTHCCRKwIbfQBx7sJOK5dBtP1oGlOR6f19Zxe9R5I5qYq/GuKx8+8yAUIaPOCQE1/pAs0breV0zuoAh3cr71ZsadYixuxKm4u8XOMm2ah26A0phrso5xNYuh86FOllTQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HChW5IQa; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZBbzAQsG; dkim-atps=neutral; spf=pass (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=derez@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HChW5IQa;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZBbzAQsG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=derez@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YSx0j3Xy9z2yMD
	for <linux-erofs@lists.ozlabs.org>; Thu,  9 Jan 2025 05:15:15 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736360111;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=maJsQJJ4eznzeJRr5m3kakizm9g83vtAwXej/TfFIcU=;
	b=HChW5IQamWe41rRpHqcqkt1Y0E2Ko5ZvC59Emp8JiMJHnlmhKFhekgULPHmOe0Gs8AVwmw
	ZGVi7ifnj6AXczvU0zUvY5i6steU/aTnDooXqF3mKPFuQzO03ZyHiWV5I2D/ZiqsydXz7W
	fV++RfFkjUImjBcqxMK7RQjHfkBa0C0=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736360112;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=maJsQJJ4eznzeJRr5m3kakizm9g83vtAwXej/TfFIcU=;
	b=ZBbzAQsGBPPcyV0ol0kGnS9F9iPzLz7CIjQSvKtmDZo9xbd6FjRywJYuSbdqo4zIniu+T+
	CFXDe/7fLlI69tzieqOmX75ueKm1qBTklg1QKuj36lhdlV3y5JNRZdBtvuVOYp2FWefvFZ
	b2U3erIBvjGCXYwXZ0lDWmodV8QeCgQ=
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-cV7QkflkNwGbLlDcE5IFbQ-1; Wed, 08 Jan 2025 13:15:10 -0500
X-MC-Unique: cV7QkflkNwGbLlDcE5IFbQ-1
X-Mimecast-MFC-AGG-ID: cV7QkflkNwGbLlDcE5IFbQ
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-85bbbba5b59so28974241.0
        for <linux-erofs@lists.ozlabs.org>; Wed, 08 Jan 2025 10:15:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736360109; x=1736964909;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=maJsQJJ4eznzeJRr5m3kakizm9g83vtAwXej/TfFIcU=;
        b=DYAylQbSNN/9/Oe9rJNaBI/0L3SDp/gGeHkQKeVyPdTfxTptODjKppdcUuC8omrBOw
         lgMIGS5NVouFH3LFw8xJmj0G1HnJ7iVgpbgJ0VCkNpaFIcdUWccgbm8kfDVo9Ku5QDDv
         JcGg7k2sEyMhXtTHPRAnNtUtCP6XzCx5LyUnXu+Pmn6QLDM1rk39QsfY1veOUF9kyueP
         6v1uNoZmBiTLZ9PTwIaL9ylQ09ZdzL9bhqM++PNpjSCVn5YRLbH7249L9cVU+pLDJkLB
         QA4D2QZMUwrqHxCaodN9HtjAJYyvZqb26MYlt90NKdcQpz+QCJTcmJX33NDoBAKKcSlJ
         JFNQ==
X-Gm-Message-State: AOJu0YzUAHeQUr59jRIQq785bNZ+tQg3yZIk7b6DQWV+27UnS/tzTAuv
	eubBI6X3MXODlJOWFFJLyxenuI0/5RnUmLmCufwNzjCTXoPPB7IxzErtxVmuMQbu8E3cypbY6h6
	+1i5+Dn34GOqMIs6WQfVixOxB126sA44n9iVl1Ry0u40FLxReQvZKvycjlaEo4x6Ix6lIbFiPj8
	Ol9QPhNZT/iyKR6G61o5I6jEikqbgN0Si9GJej+ys4nU2aJP8=
X-Gm-Gg: ASbGncvVi3fgaFpolhoNHSJS6/0LmHYImMEchTrRyifYiNfB4XtW8UMJlTwM1oBNkyb
	JLGIAezk6ksLvC08vZlr7B/Ronnbi2n0mcKuZTdE=
X-Received: by 2002:a05:6122:50b:b0:50c:9834:57b3 with SMTP id 71dfb90a1353d-51c6c46b338mr3071139e0c.4.1736360109113;
        Wed, 08 Jan 2025 10:15:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFCpUQ+BtV8iQcOAixIx/enxj3Yex2NGKKbrTBo22udkBacK607F7RxRDzyBEgsQhcu8r1yHJAgXf864x1FeeE=
X-Received: by 2002:a05:6122:50b:b0:50c:9834:57b3 with SMTP id
 71dfb90a1353d-51c6c46b338mr3071115e0c.4.1736360108822; Wed, 08 Jan 2025
 10:15:08 -0800 (PST)
MIME-Version: 1.0
From: Daniel Erez <derez@redhat.com>
Date: Wed, 8 Jan 2025 20:14:57 +0200
X-Gm-Features: AbW1kvY6urD3x-RcVZF5Br3G4NjqGhLax9nSKC407R8XlGZncYbgbsrFx2di7bI
Message-ID: <CAP84NrvY7nfYOdS6KbGeOCwGTKAdoNbgsu61S-YQj-3Bt4bCEg@mail.gmail.com>
Subject: [feature request] extract a single file from EROFS filesystem
To: linux-erofs@lists.ozlabs.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: D56-VnXva4bJ4FU8xyAaSP-JfO__34-cFJtywmVO96s_1736360109
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="0000000000007d2a5a062b35d7a3"
X-Spam-Status: No, score=-0.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org
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
Cc: Linoy Hadad <lhadad@redhat.com>, "Kaplan, Alona" <alkaplan@redhat.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

--0000000000007d2a5a062b35d7a3
Content-Type: text/plain; charset="UTF-8"

Hi,

According to fsck.erofs manual [1], the tool supports extracting the whole
file system.
Would it be applicable to introduce an option for extracting a specific
file from the image?
I.e. something similar to the '-extract-file' option available in
unsquashfs tool [2].
Or, is there any other alternative for extracting a file from an EROFS
image?

[1] https://man.archlinux.org/man/extra/erofs-utils/fsck.erofs.1.en#extract
[2]
https://manpages.debian.org/testing/squashfs-tools/unsquashfs.1.en.html#extract

Thanks!
Daniel

--0000000000007d2a5a062b35d7a3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<br><br>According to fsck.erofs manual [1], the tool su=
pports extracting the whole file system.<br>Would it be applicable to intro=
duce an option for extracting a specific file from the image?<br>I.e. somet=
hing similar to the &#39;-extract-file&#39; option available in unsquashfs =
tool [2].<div>Or, is there any other alternative for extracting=C2=A0a file=
 from an EROFS image?<br><br>[1] <a href=3D"https://man.archlinux.org/man/e=
xtra/erofs-utils/fsck.erofs.1.en#extract">https://man.archlinux.org/man/ext=
ra/erofs-utils/fsck.erofs.1.en#extract</a><br>[2] <a href=3D"https://manpag=
es.debian.org/testing/squashfs-tools/unsquashfs.1.en.html#extract">https://=
manpages.debian.org/testing/squashfs-tools/unsquashfs.1.en.html#extract</a>=
<br><br>Thanks!<br>Daniel<br><div><br></div></div></div>

--0000000000007d2a5a062b35d7a3--

