Return-Path: <linux-erofs+bounces-1473-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C7CAC99E9F
	for <lists+linux-erofs@lfdr.de>; Tue, 02 Dec 2025 03:50:28 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dL4yB16wFz3bl1;
	Tue, 02 Dec 2025 13:50:26 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.28.63
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1764643826;
	cv=none; b=K5S0eGmT91nQS6G/npzfmWYLvbBD99By+aq28pf8fFZEg3EvDu22Geo36/JCW4n249p9yiHMn/rmAtI3Zka6nrwIN8e2EGHveGZdJANauVquhV0/mTOhNBuMQPpx4SqEL4HLSSvpgE1AZ3M7El2QCHEqnt1WwTlb84c6QMFOVKmxWgDiK+5qUuzDl3TBIhrU1GgJkPHWb4i5v/ipAACjco/XA9j12v0w7YcmzmvsiP+zsX3p6SVPHWHHkQdjwOgxnA+cPuSw/i1eVTPWskCF9e9z41/SOha0HWNrTXVq4dI+J5JLJqaThBKg9nEkrzjD7iAAbJ+kaWOPkpcxs3SQ/A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1764643826; c=relaxed/relaxed;
	bh=XHPirPrmQLviUs2OhotzxdxQTqKOZe79aOeNvcSmcmo=;
	h=From:Message-Id:Content-Type:Mime-Version:Subject:Date:
	 In-Reply-To:Cc:To:References; b=MegH8FEe0RJSH5ciYxO4v8+jCJlE6v2E11QwGf6TQdrvX/tTiNNxr5Ic8Uh11dOTUSlJj2qnmRlGnpaE3RgjCmSIvD5DHFhEPiCfEiAsXia0fl41j3BFxXYLLqSo7UZQi17/TsXA1OvZHRhBm/UkC1ji/BH2uzoAiNWeuNMLzuE6y7xOxIbvG+XLwc7GkMRzJM9K+oBzxfrM6UQlop97aLE0lYJq3zdvdZdUCSMtmoNqpddA8DeCrocLb4gZvo7s4tXFJX/TZa/mnV10NBsiEShMzFhYkGYDvXHMtjO34iD8lq7TsMCcxkfDKYJUlFunDHCDDTOYs/FJluwRSdTMkA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=cyzhu.com; spf=pass (client-ip=115.124.28.63; helo=out28-63.mail.aliyun.com; envelope-from=hudson@cyzhu.com; receiver=lists.ozlabs.org) smtp.mailfrom=cyzhu.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=cyzhu.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=cyzhu.com (client-ip=115.124.28.63; helo=out28-63.mail.aliyun.com; envelope-from=hudson@cyzhu.com; receiver=lists.ozlabs.org)
Received: from out28-63.mail.aliyun.com (out28-63.mail.aliyun.com [115.124.28.63])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dL4y85M6Rz3bfR
	for <linux-erofs@lists.ozlabs.org>; Tue, 02 Dec 2025 13:50:21 +1100 (AEDT)
Received: from smtpclient.apple(mailfrom:hudson@cyzhu.com fp:SMTPD_---.fao.NRq_1764643815 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 02 Dec 2025 10:50:16 +0800
From: hudsonZhu <hudson@cyzhu.com>
Message-Id: <7744F2F2-F376-4ECD-A609-5CC4B477E8A8@cyzhu.com>
Content-Type: multipart/alternative;
	boundary="Apple-Mail=_D9BCCFF3-6C0C-4DDC-A608-66E8E5053CBB"
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
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.500.181.1.5\))
Subject: Re: [PATCH v1] erofs-utils: mount: add manpage and usage information
Date: Tue, 2 Dec 2025 10:50:05 +0800
In-Reply-To: <204548c7-3c09-4e05-aa44-9abf00f4009d@huawei.com>
Cc: linux-erofs@lists.ozlabs.org,
 hsiangkao@linux.alibaba.com,
 Chengyu Zhu <hudsonzhu@tencent.com>
To: "zhaoyifan (H)" <zhaoyifan28@huawei.com>
References: <20251130033516.86065-1-hudson@cyzhu.com>
 <204548c7-3c09-4e05-aa44-9abf00f4009d@huawei.com>
X-Mailer: Apple Mail (2.3826.500.181.1.5)
X-Spam-Status: No, score=0.0 required=3.0 tests=HTML_MESSAGE,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org


--Apple-Mail=_D9BCCFF3-6C0C-4DDC-A608-66E8E5053CBB
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

Thanks, I=E2=80=99ll fix it.

Thanks,
Chengyu

> 2025=E5=B9=B412=E6=9C=881=E6=97=A5 21:54=EF=BC=8Czhaoyifan (H) =
<zhaoyifan28@huawei.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
>=20
>=20
> On 2025/11/30 11:35, ChengyuZhu6 wrote:
>=20
>> +static void usage(int argc, char **argv)
>> +{
>> +	printf("Usage: %s [OPTIONS] SOURCE [MOUNTPOINT]\n"
>> +	       "Manage EROFS filesystem.\n"
>> +	       "\n"
>> +	       "General options:\n"
>> +	       " -V, --version         print the version number of =
mount.erofs and exit\n"
>> +	       " -h, --help            display this help and exit\n"
>> +	       " -o options            comma-separated list of mount =
options\n"
>> +	       " -t type[.subtype]     filesystem type (and optional =
subtype)\n"
>> +	       "                       subtypes: fuse, local, nbd\n"
>> +	       " -u                    unmount the filesystem\n"
>> +	       "    --reattach         reattach to an existing NBD =
device\n"
> Hi Chengyu,
>=20
> Seems wrong indent here.
>=20
>=20
>=20
> Thanks,
> Yifan Zhao
>=20
>=20
>=20
>> +#ifdef OCIEROFS_ENABLED
>>=20


--Apple-Mail=_D9BCCFF3-6C0C-4DDC-A608-66E8E5053CBB
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=utf-8

<html><head><meta http-equiv=3D"content-type" content=3D"text/html; =
charset=3Dutf-8"></head><body style=3D"overflow-wrap: break-word; =
-webkit-nbsp-mode: space; line-break: after-white-space;">Thanks, I=E2=80=99=
ll fix it.<div><br></div><div>Thanks,</div><div>Chengyu<br =
id=3D"lineBreakAtBeginningOfMessage"><div><br><blockquote =
type=3D"cite"><div>2025=E5=B9=B412=E6=9C=881=E6=97=A5 21:54=EF=BC=8Czhaoyi=
fan (H) &lt;zhaoyifan28@huawei.com&gt; =E5=86=99=E9=81=93=EF=BC=9A</div><b=
r class=3D"Apple-interchange-newline"><div>

 =20
    <meta http-equiv=3D"Content-Type" content=3D"text/html; =
charset=3DUTF-8">
 =20
  <div><p><br>
    </p>
    <div class=3D"moz-cite-prefix">On 2025/11/30 11:35, ChengyuZhu6 =
wrote:<span style=3D"white-space: pre-wrap">
</span><span style=3D"white-space: pre-wrap">
</span></div>
    <blockquote type=3D"cite" =
cite=3D"mid:20251130033516.86065-1-hudson@cyzhu.com">
      <pre wrap=3D"" class=3D"moz-quote-pre">+static void usage(int =
argc, char **argv)
+{
+	printf("Usage: %s [OPTIONS] SOURCE [MOUNTPOINT]\n"
+	       "Manage EROFS filesystem.\n"
+	       "\n"
+	       "General options:\n"
+	       " -V, --version         print the version number of =
mount.erofs and exit\n"
+	       " -h, --help            display this help and exit\n"
+	       " -o options            comma-separated list of mount =
options\n"
+	       " -t type[.subtype]     filesystem type (and optional =
subtype)\n"
+	       "                       subtypes: fuse, local, nbd\n"
+	       " -u                    unmount the filesystem\n"
+	       "    --reattach         reattach to an existing NBD =
device\n"</pre>
    </blockquote><p>Hi Chengyu,</p><p>Seems wrong indent =
here.</p><p><br>
    </p><p>Thanks,<br>
      Yifan Zhao</p><p><br>
    </p>
    <blockquote type=3D"cite" =
cite=3D"mid:20251130033516.86065-1-hudson@cyzhu.com">
      <pre wrap=3D"" class=3D"moz-quote-pre">+#ifdef OCIEROFS_ENABLED

</pre>
    </blockquote>
  </div>

</div></blockquote></div><br></div></body></html>=

--Apple-Mail=_D9BCCFF3-6C0C-4DDC-A608-66E8E5053CBB--

